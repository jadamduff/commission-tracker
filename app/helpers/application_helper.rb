module ApplicationHelper

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to login_path if !logged_in?
  end

  def is_current_users_profile?
    (current_user.id == @user.id) && (params[:controller] == 'users' && params[:action] == 'show')
  end

  def is_current_users_employee?
    current_user.employees.include?(@user)
  end

  def is_employees_manager?
    current_user.manager_id != nil && @user.id == current_user.manager_id
  end

  def is_managers_profile?
    @user.is_manager? && current_user.manager_id == @user.id
  end

  def current_user_is_manager?
    current_user.is_manager? == true
  end

  def has_employees?
    @user.is_manager? && !@user.employees.empty?
  end

  def number_sold(product_id)
    quantity = 0
    @user.sales.where('product_id = ?', product_id).each do |sale|
      quantity += sale.quantity
    end
    return quantity
  end

  def display_number_sold(product_id)
    "#{number_sold(product_id)} Sold"
  end

  def set_form_variables
    if current_user.is_manager?

    else
      @sale = Sale.new
      @manager_products = Product.where('manager_id = ?', current_user.manager_id)
    end
  end

end
