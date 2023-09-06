class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

p Pizza.new('oh').instance_variables
p Fruit.new('hello').instance_variables