class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben is right because the attr_reader acts as a method that returns the value of @balance when the balance method is called, thus it proxies as @balance in the positive_balance? method