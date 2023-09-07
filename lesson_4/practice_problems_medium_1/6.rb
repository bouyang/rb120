class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    self.template
  end
end

# In the first code, the show_template method calls the template method which is created by Ruby because there is an attr_acessor for the template instance variable.
# From the template method, it will simply return @template

# In the second code, the show_template method calls the template method as well on self, which will be the Computer object. For that method call, it will also
# return the @template