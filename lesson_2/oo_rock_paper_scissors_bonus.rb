require 'pry'


class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  @@history = []

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    rock? && other_move.scissors? ||
      rock? && other_move.lizard? ||
      paper? && other_move.spock? ||
      paper? && other_move.rock? ||
      scissors? && other_move.lizard? ||
      scissors? && other_move.paper? ||
      lizard? && other_move.spock? ||
      lizard? && other_move.paper? ||
      spock? && other_move.rock? ||
      spock? && other_move.scissors?

    #rock? && other_move.scissors? || rock? && other_move.lizard? || paper? && other_move.spock? || paper? && other_move.rock? || scissors && other_move.lizard? || scissors? && other_move.paper? || lizard? && other_move.spock? || lizard? && other_move.paper? || spock? && other_move.rock? || spock? && other_move.scissors?
  end

  def to_s
    @value
  end

  def self.add_move(move1, move2)
    @@history.push([move1, move2])
  end

  def self.display_history
    puts "The moves that were played:"
    @@history.each do |round|
      puts "#{round[0]} vs #{round[1]}"
    end
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock"
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors', 'lizard', 'spock'].include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  MAX_SCORE = 3

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif computer.move > human.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def check_score
    puts "#{human.name} score: #{human.score}"
    puts "#{computer.name} score: #{computer.score}"

    if human.score == MAX_SCORE
      puts "#{human.name} wins the game!"
      human.score = 0
      computer.score = 0
    elsif computer.score == MAX_SCORE
      puts "#{computer.name} wins the game!"
      human.score = 0
      computer.score = 0
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return true if answer == 'y'
    false
  end

  def record_move
    Move.add_move(human.move, computer.move)
  end

  def display_history
    Move.display_history
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      record_move
      display_moves
      display_winner
      check_score
      break unless play_again?
    end
    display_history
    display_goodbye_message
  end
end

RPSGame.new.play
