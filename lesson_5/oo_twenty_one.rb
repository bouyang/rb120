class Participant
  VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5,
             '6' => 6,  '7' => 7,  '8' => 8, '9' => 9, '10' => 10,
             'J' => 10, 'Q' => 10, 'K' => 10 }

  attr_accessor :hand

  def initialize
    @hand = []
  end

  def hit(card)
    hand.push(card)
  end

  def busted?
    total > 21
  end

  def total
    sum = 0
    hand.each do |card|
      sum += VALUES[card.number]
    end
    if sum > 21
      hand.each do |card|
        sum -= 10 if card.number == 'A'
      end
    end
    sum
  end
end

class Player < Participant
  def show_hand
    output = []
    hand.each do |card|
      output.push("#{card.number} of #{card.suit}")
    end
    puts "You have: #{output.join(', ')}"
  end
end

class Dealer < Participant
  def show_hand(initial: true)
    output = []
    if initial
      puts "Dealer has: #{hand[0].number} of #{hand[0].suit} and an unknown"
    else
      hand.each do |card|
        output.push("#{card.number} of #{card.suit}")
      end
      puts "Dealer has: #{output.join(', ')}"
    end
  end

  def keep_hitting?
    total < 17
  end
end

class Deck
  SUITS = ['D', 'H', 'C', 'S']
  CARDS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.each do |suit|
      CARDS.each do |number|
        @cards.push(Card.new(suit, number))
      end
    end
  end

  def initial_deal
    hand1 = []
    hand2 = []
    4.times do |time|
      new_card = cards.sample
      hand1.push(new_card) if time.odd?
      hand2.push(new_card) if time.even?
      cards.delete(new_card)
    end
    return hand1, hand2
  end

  def deal
    card = cards.sample
    cards.delete(card)
    card
  end
end

class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    loop do
      clear
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn
      show_result
      break unless play_again?
      reset
    end
  end

  def clear
    system 'clear'
  end

  def deal_cards
    @deck = Deck.new
    hand1, hand2 = deck.initial_deal
    player.hand = hand1
    dealer.hand = hand2
  end

  def show_initial_cards
    player.show_hand
    dealer.show_hand
  end

  def player_turn
    loop do
      puts "\nWould you like to hit or stay?"
      decision = nil
      loop do
        decision = gets.chomp
        break if decision == 'hit' || decision == 'stay'
        puts "Sorry, not a valid choice"
      end

      break if player.busted? || decision == 'stay'

      player.hit(deck.deal)
      player.show_hand

      break if player.busted?
    end
  end

  def dealer_turn
    if !player.busted?
      loop do
        break if !dealer.keep_hitting?
        dealer.hit(deck.deal)
      end
    end
    puts ""
    dealer.show_hand(initial: false)
  end

  def show_result
    puts "\nYour total: #{player.total}. Dealer total: #{dealer.total}."
    if !someone_busted.nil?
      puts "#{someone_busted} busted!"
    elsif player.total > dealer.total
      puts "You win!"
    elsif player.total < dealer.total
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
  end

  def someone_busted
    return 'Dealer' if dealer.busted?
    return 'Player' if player.busted?
    nil
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry invalid choice"
    end
    answer == 'y'
  end

  def reset
    player.hand = []
    dealer.hand = []
  end
end

Game.new.start
