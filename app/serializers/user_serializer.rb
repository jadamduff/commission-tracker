class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_manager
  attribute :manager_data, if: :is_manager
  attribute :employee_data, if: :is_employee

  def is_manager
    self.object.is_manager?
  end

  def is_employee
    !self.object.is_manager?
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
            color: product.color,
            title: product.title,
            price: product.display_price,
            commission: product.commission_to_percent + '% Commission',
            sale_count: product.sale_count,
            revenue: product.revenue,
            is_free: product.is_free?
          }
        end,

        employees: self.object.employees.map do |employee|
          {
            name: employee.name,
            revenue: employee.revenue,
            url: '/users/' + employee.manager_id.to_s + '/employees/' + employee.id.to_s
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

      manager_products: Product.where('manager_id = ?', self.object.manager_id).map do |product|
        {
          id: product.id,
          title: product.title
        }
      end,

      sales: self.object.sales.map do |sale|
        {
          id: sale.id,
          earnings: sale.display_earnings,
          total: sale.display_total,
          quantity: sale.quantity,
          productColor: sale.product.color,
          productTitle: sale.product.title,
          commission: sale.product.commission_to_percent + '% Commission',
          isFree: sale.product.is_free?
        }
      end,

      products_sold: self.object.products.map do |product|
        {
          id: product.id,
          title: product.title,
          price: product.display_price,
          commission: product.commission_to_percent + '% Commission',
          isFree: product.is_free?,
          numberSold: number_sold(product.id),
          color: product.color
        }
      end
    }
  end

end
