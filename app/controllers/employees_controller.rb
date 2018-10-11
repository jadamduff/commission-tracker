class EmployeesController < ApplicationController

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
      @products = @manager.products
      @sales = @user.sales
    end
  end

end
