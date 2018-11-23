class ProductSerializer < ActiveModel::Serializer
  attributes :id, :data

  def data
    {
      id: self.object.id,
      color: self.object.color,
      title: self.object.title,
      price: self.object.display_price,
      commission: self.object.commission_to_percent + '% Commission',
      sale_count: self.object.sale_count,
      revenue: self.object.revenue,
      is_free: self.object.is_free?
    }
  end
end
