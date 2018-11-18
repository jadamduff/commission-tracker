class Product < ApplicationRecord
  has_many :sales
  has_many :users, through: :sales

  validates_presence_of :title, :price, :commission, :color
  validates :price, numericality: true

  include ActionView::Helpers

  def self.list_hot_products(user_id)
    self.joins(:sales).group('products.id').where('products.manager_id = ?', user_id).order('count(sales.id) DESC').limit(3).select('products.*')
  end

  def commission_to_percent
    "#{(self.commission * 100).to_i}"
  end

  def revenue
    total = 0.0
    self.sales.each do |sale|
      total += sale.product.price * sale.quantity
    end
    if total % 1 == 0
      return "#{number_to_currency(total, precision: 0)}"
    else
      return "#{number_to_currency(total, precision: 2)}"
    end
  end

  def formatted_price
    if self.price % 1 == 0
      return self.price.to_i
    else
      return '%.2f' % self.price.round(2)
    end
  end

  def display_price
    if self.is_free?
      return "Free"
    else
      if self.formatted_price % 1 == 0
        "#{number_to_currency(self.formatted_price, precision: 0)}"
      else
        "#{number_to_currency(self.formatted_price, precision: 2)}"
      end
    end
  end

  def is_free?
    self.price == 0
  end

  def sale_count
    pluralize(self.sales.count, 'Sale')
  end

end
