class SaleSerializer < ActiveModel::Serializer
  attributes :id, :data

  def number_sold(product_id)
    quantity = 0
    self.object.user.sales.where('product_id = ?', product_id).each do |sale|
      quantity += sale.quantity
    end
    return quantity
  end

  def data
    {
      totalEarnings: self.object.user.display_total_earnings,
      sale:
        {
          id: self.object.id,
          earnings: self.object.display_earnings,
          total: self.object.display_total,
          quantity: self.object.quantity,
          productColor: self.object.product.color,
          productTitle: self.object.product.title,
          commission: self.object.product.commission_to_percent + '% Commission',
          isFree: self.object.product.is_free?
        },
      product:
        {
          id: self.object.product.id,
          title: self.object.product.title,
          price: self.object.product.display_price,
          commission: self.object.product.commission_to_percent + '% Commission',
          isFree: self.object.product.is_free?,
          numberSold: number_sold(self.object.product.id),
          color: self.object.product.color
        }
      }
  end

end
