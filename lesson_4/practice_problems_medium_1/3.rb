class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# changing attr_reader will work for quantity but it also causes product_name to have a = method created for it and if you don't want to
# have that method available in case it is accidentally causes product name to be changed, then it is not advisable to change both to attr_accessor