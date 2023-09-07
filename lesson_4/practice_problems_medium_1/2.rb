class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# By only include the attr_reader for the quantity instance variable, Ruby will only create a method to read @quantity so in line 11, quantity is initialized as
# a local variable in the update_quantity method instead of the intended use of updating the quantity instance variable
# to fix this, you can add attr_writer :quantity and then in line 11 change it to self.quantity, which will then call the quantity= method that Ruby creates when
# attr_writer is included