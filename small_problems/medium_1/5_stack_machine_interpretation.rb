class Minilang
  def initialize(commands)
    @commands = commands
    @register = Register.new
    @stack = Stack.new
  end

  def eval
    com_queue = @commands.split
    
    com_queue.each do |com|
      if com.to_i.to_s == com
        @register.value = com.to_i
      elsif com == 'PRINT'
        @register.to_s
      elsif com == 'PUSH'
        @stack.push(@register.value)
      elsif com == 'ADD'
        @register.value = @register.value + @stack.pop
      elsif com == 'SUB'
        @register.value = @register.value - @stack.pop
      elsif com == 'MULT'
        @register.value = @register.value * @stack.pop
      elsif com == 'DIV'
        @register.value = @register.value / @stack.pop
      elsif com == 'MOD'
        @register.value = @register.value % @stack.pop
      elsif com == 'POP'
        @register.value = @stack.pop
      else
        puts "Invalid token: #{com}"
        break
      end
    end
  end
end

class Register
  attr_accessor :value

  def initialize
    @value = 0
  end

  def to_s
    if value.nil?
      puts "Empty!"
    else
      puts value
    end
  end
end

class Stack
  attr_accessor :queue

  def initialize
    @queue = []
  end

  def push(ele)
    queue.push(ele)
  end

  def pop
    queue.pop
  end

end

Minilang.new('PRINT').eval
# 0

Minilang.new('2').eval

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)