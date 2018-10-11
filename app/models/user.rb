class User < ApplicationRecord
  has_secure_password
  has_many :sales
  has_many :products, through: :sales
  has_many :manager_employees
  has_many :employees, through: :manager_employees

  validates_presence_of :name, :email, :password, on: :create
  validates_uniqueness_of :email, on: :create
  validates_acceptance_of :manager, :unless => :manager_id?
  validates_presence_of :manager_id, :unless => :manager?
  validate :manager_or_employee
  validate :valid_manager

  def is_manager?
    self.manager == true
  end

  def revenue
    total = 0.0
    self.sales.each do |sale|
      total += sale.product.price * sale.quantity
    end
    return "$#{total.round}"
  end

  private

  def valid_manager
    if manager_id != nil && User.find(manager_id).manager == false
      errors.add(:manager_id, "There is no manager with that email address.")
    end
  end

  def manager_or_employee
    if manager == true && manager_id != nil
      errors.add(:manager, "Cannot be a manager and emplyee.")
    end
  end

end
