class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

banko = AngryCat.new(2, 'bankos')

banana = AngryCat.new(3, 'bananer')