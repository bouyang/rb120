class Person
  attr_accessor :name, :first_name, :last_name

  def initialize(name)
    @name = name
    @first_name = name
    @last_name = ''
  end

  def name
    if last_name == ''
      first_name
    else
      first_name + ' ' + last_name
    end
  end

end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'