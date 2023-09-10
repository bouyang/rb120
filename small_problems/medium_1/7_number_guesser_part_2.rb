class GuessingGame
  attr_reader :target, :player_guess
  attr_accessor :guesses_remaining

  def initialize(start_range, end_range)
    @start_range = start_range
    @end_range = end_range
    @target = rand(start_range..end_range)
    @guesses_remaining = Math.log2(end_range - start_range).to_i + 1
    @player_guess = 0
    @continue = true
  end

  def play
    loop do
      print_guesses
      take_guess
      evaluate_guess
      break unless continue_guessing?
    end
  end

  def set_start_values
    
  end

  def print_guesses
    puts "You have #{guesses_remaining} guesses remaining."
  end

  def take_guess
    puts "Enter a number between #{@start_range} and #{@end_range}: "
    @player_guess = gets.chomp.to_i
    self.guesses_remaining -= 1
  end

  def evaluate_guess
    if player_guess > target
      puts "Your guess is too high."
      puts ""
    elsif player_guess < target
      puts "Your guess is too low."
      puts ""
    else
      puts "That's the number!"
      puts ""
      puts "You won!"
      @continue = false
    end
  end

  def continue_guessing?
    if guesses_remaining == 0
      @continue = false
      puts "You have no more guesses. You lost!"
    end
    @continue
  end
end

game = GuessingGame.new(501, 1500)
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!