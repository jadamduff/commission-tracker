class Product < ApplicationRecord
  has_many :sales
  has_many :users, through: :sales

  validates_presence_of :title, :price, :commission, :color

  def commission_to_percent
    "#{(self.commission * 100).to_i}"
  end

  def revenue
    total = 0.0
    self.sales.each do |sale|
      total += sale.product.price * sale.quantity
    end
    return "$#{total.round}"
  end

  def formatted_price
    if self.price % 1 == 0
      return "#{self.price.to_i}"
    else
      return "#{'%.2f' % self.price.round(2)}"
    end
  end

  def display_price
    self.is_free? ? "Free" : "$#{self.formatted_price}"
  end

  def is_free?
    self.price == 0
  end

end
