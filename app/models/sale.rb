class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_presence_of :product_id, :quantity

  def total
    total_a = self.product.price * self.quantity
    if total_a % 1 == 0
      return total_a.to_i
    else
      return '%.2f' % total_a.round(2)
    end
  end

  def display_total
    "$#{self.total}"
  end

end
