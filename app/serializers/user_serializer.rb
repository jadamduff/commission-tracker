class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_manager, :manager_data, :employee_data

  def is_manager
    self.object.is_manager?
  end

  def number_sold(product_id)
    quantity = 0
    self.object.sales.where('product_id = ?', product_id).each do |sale|
      quantity += sale.quantity
    end
    return quantity
  end

  def manager_data
      {
        products: Product.where('manager_id = ?', self.object.id).map do |product|
          {
            id: product.id,
            title: product.title,
            price: product.display_price,
            commission: product.commission_to_percent,
            manager_id: product.manager_id,
            color: product.color,
            is_free?: product.is_free?,
            sale_count: product.sale_count,
            revenue: product.revenue
          }
        end,

        employees: self.object.employees.map do |employee|
          {
            name: employee.name,
            revenue: employee.revenue
          }
        end
      }
  end

  def employee_data
    {
      totalEarnings: self.object.display_total_earnings,
      manager:
        {
          name: User.find(self.object.manager_id).name,
          url: '/users/' + User.find(self.object.manager_id).id.to_s
        },
      sales: self.object.sales.map do |sale|
        {
          product_title: sale.product.title,
          earnings: sale.display_earnings,
          total: sale.display_total,
          commission: sale.product.commission_to_percent + '% Commission',
          quantity: sale.quantity,
          is_free?: sale.product.is_free?,
          product_color: sale.product.color
        }
      end,

      manager_products: Product.where('manager_id = ?', self.object.manager_id).map do |product|
        {
          id: product.id,
          title: product.title
        }
      end,

      products_sold: self.object.products.map do |product|
        {
          id: product.id,
          title: product.title,
          number_sold: number_sold(product.id),
          price: product.display_price,
          commission: product.commission_to_percent + '% Commission',
          is_free?: product.is_free?,
          color: product.color
        }
      end
    }
  end

end
