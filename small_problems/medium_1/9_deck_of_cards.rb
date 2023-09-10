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

deck = Deck.new
drawn = []
deck.draw
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.