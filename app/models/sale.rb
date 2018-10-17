class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_presence_of :product_id, :quantity

  include ActionView::Helpers

  def total
    total_a = self.product.price * self.quantity
    if total_a % 1 == 0
      return total_a.to_i
    else
      return '%.2f' % total_a.round(2)
    end
  end

  def display_total
    if self.total % 1 == 0
      "#{number_to_currency(self.total, precision: 0)}"
    else
      "#{number_to_currency(self.total, precision: 2)}"
    end
  end

  def earnings
    total_a = self.total.to_i * self.product.commission
    if total_a % 1 == 0
      return total_a.to_i
    else
      return '%.2f' % total_a.round(2)
    end
  end

  def display_earnings
    if self.earnings % 1 == 0
      "#{number_to_currency(self.earnings, precision: 0)}"
    else
      "#{number_to_currency(self.earnings, precision: 2)}"
    end
  end

end
