class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def display_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

