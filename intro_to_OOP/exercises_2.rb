module Towable
  def towing
    puts "This vehicle can tow"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@num_vehicles = 0

  def self.mileage(gallons, miles)
    puts "Mileage is #{miles / gallons} MPG"
  end

  def self.num_vehicles
    puts "There are #{@@num_vehicles} vehicles"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@num_vehicles += 1
  end

  def speed_up(num)
    @speed += num
    puts "Increased speed by #{num} to #{speed}"
  end

  def brake(num)
    @speed -= num
    puts "Decreased speed by #{num} to #{speed}"
  end

  def shut_off
    @speed = 0
    puts "Shut off car, speed is now #{speed}"
  end

  def spray_paint(col)
    self.color = col
    puts "Painted the car #{color}!"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end

end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "My car is a #{year}, #{color}, #{model}"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Towable
  def to_s
    "My truck is a #{year}, #{color}, #{model}"
  end
end

camry = MyCar.new('2000', 'camry', 'black')
puts camry
ram = MyTruck.new('2010', 'ram', 'white')
puts ram

puts ram.towing

puts Vehicle.num_vehicles

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

puts camry.age