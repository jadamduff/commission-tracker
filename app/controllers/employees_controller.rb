class EmployeesController < ApplicationController

  before_action :require_login, only: [:show]
  before_action :set_form_variables, only: [:show]

  def show
    @user = User.find(params[:id])
    set_show_variables
    valid_page_view
  end

  def valid_page_view
    if !(is_current_users_profile? || is_current_users_employee? || is_employees_manager?)
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end

  def set_show_variables
    if @user.is_manager?
      @employees = @user.employees
      @products = @user.products
    else
      @manager = User.find(@user.manager_id)
      @products = @user.products.uniq
      @sales = @user.sales
    end
  end

end
