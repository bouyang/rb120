require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :wins

  def initialize(marker, name)
    @marker = marker
    @name = name
    @wins = 0
  end

  def win
    self.wins += 1
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  TOTAL_WINS_TO_VICTORY = 3

  attr_reader :board, :human, :computer

  def initialize(name)
    comp_name = ['R2D2', 'HAL', 'Watson', 'ENIAC', 'Dell Inspiron'].sample
    @board = Board.new
    @human = Player.new(HUMAN_MARKER, name)
    @computer = Player.new(COMPUTER_MARKER, comp_name)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      display_result
      break if victory?
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "#{human.name} is a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def joinor(arr, punc=', ', word='or')
    return '' if arr.size == 0
    return arr[0].to_s if arr.size == 1
    return arr.join(" #{word} ") if arr.size == 2
    if arr.size >= 3
      result = ''
      0.upto(arr.size - 2).each do |ele|
        result << arr[ele].to_s
        result << punc
      end
      result << word + " "
      result << arr[-1].to_s
      return result
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if computer_offense != nil
      board[computer_offense] = computer.marker
    elsif computer_defense != nil
      board[computer_defense] = computer.marker
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def at_risk_square(mark_check)
    board.class::WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      count = 0
      squares.each do |sq|
        if sq.marker == mark_check
          count += 1
        end
      end
      if count == 2
        squares.each_with_index do |sq, idx|
          if sq.marker == ' '
            return line[idx]
          end
        end
      end
    end
    nil
  end

  def computer_defense
    at_risk_square(HUMAN_MARKER)
  end

  def computer_offense
    at_risk_square(COMPUTER_MARKER)
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def victory?
    if human.wins == TOTAL_WINS_TO_VICTORY
      puts "#{human.name} won #{TOTAL_WINS_TO_VICTORY} games!"
      return true
    elsif computer.wins == TOTAL_WINS_TO_VICTORY
      puts "#{computer.name} won #{TOTAL_WINS_TO_VICTORY} games!"
      return true
    end
    false
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
      human.win
    when computer.marker
      puts "#{computer.name} won!"
      computer.win
    else
      puts "It's a tie!"
    end

    puts "Current score is #{human.name}: #{human.wins}, #{computer.name}: #{computer.wins}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

puts "What is your name?"
name = gets.chomp

game = TTTGame.new(name)
game.play
