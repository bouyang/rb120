class Card
  include Comparable

  VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def to_s
    "#{rank.to_s} of #{suit}"
  end

  def <=>(other)
    value <=> other.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    reset
  end

  def draw
    if @deck.empty?
      reset
      @deck.pop
    else
      @deck.pop
    end
  end

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck.push(Card.new(rank, suit))
      end
    end
    @deck = @deck.shuffle
  end
end
# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
    @hand = []
    5.times do
      @hand.push(deck.draw)
    end
  end

  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless suits.uniq.count == 1
    return false unless ranks.sort == [10, 11, 12,13, 14]
    true
  end

  def straight_flush?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless suits.uniq.count == 1
    return false unless ranks.sort == (ranks.min..ranks.max).to_a
    true
  end

  def four_of_a_kind?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless ranks.count(ranks.sort[0]) == 4 || ranks.count(ranks.sort[1]) == 4
    true
  end

  def full_house?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless (ranks.count(ranks.sort.min) == 3 && ranks.count(ranks.sort.max) == 2 || ranks.count(ranks.sort.min) == 2 && ranks.count(ranks.sort.max) == 3)
    true
  end

  def flush?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless suits.uniq.count == 1
    true
  end

  def straight?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless ranks.sort == (ranks.min..ranks.max).to_a
    true
  end

  def three_of_a_kind?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless (ranks.count(ranks.sort[0]) == 3 || ranks.count(ranks.sort[1]) == 3 || ranks.count(ranks.sort[2]) == 3)
    true
  end

  def two_pair?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless ranks.uniq.size == 3 && (ranks.count(ranks.sort[0]) == 1 || ranks.count(ranks.sort[1]) == 1 || ranks.count(ranks.sort[2]) == 1 || ranks.count(ranks.sort[3]) == 1)
    true
  end

  def pair?
    suits = []
    ranks = []
    @hand.each do |card|
      suits << card.suit
      ranks << card.value
    end

    return false unless (ranks.count(ranks.sort[0]) == 2 || ranks.count(ranks.sort[1]) == 2 || ranks.count(ranks.sort[2]) == 2 || ranks.count(ranks.sort[3]) == 2)
    true
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'