class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
# no method
tv.model
# invokes model instance method

Television.manufacturer
# invokes manufacturer class method
Television.model
# no method