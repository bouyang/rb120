class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# @@cats_count is a class variable for the Cat class. IT works by being incremented by 1 every type the initialize instance method is called ie. when a new instance is initialized ie. when a new
# Cat object is created