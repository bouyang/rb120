class Transform
  def initialize(str)
    @msg = str
  end

  def uppercase
    "#{@msg.upcase}"
  end

  def self.lowercase(str)
    str.downcase
  end

end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')