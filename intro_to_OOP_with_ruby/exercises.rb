class MyCar
  attr_accessor :color, :speed, :model
  attr_reader :year

  def self.mileage(gallons, miles)
    puts "Mileage is #{miles / gallons}."
  end

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
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

  def to_s
    "This car is a #{year} #{color} #{model}."
  end

end

my_car = MyCar.new('2000', 'black', 'camry')

my_car.speed_up(10)
my_car.speed_up(20)
my_car.shut_off
my_car.speed_up(30)
my_car.brake(10)

my_car.spray_paint('yellow')
puts my_car.color

MyCar.mileage(10, 200)

puts my_car