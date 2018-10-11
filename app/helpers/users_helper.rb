module UsersHelper
  def valid_page_view
    redirect_to user_path(current_user) unless is_current_users_profile? || is_current_users_employee? || is_employees_manager?
  end

  def set_show_variables
    if @user.is_manager?
      @employees = @user.employees
      @products = Product.where('manager_id = ?', @user.id)
    else
      @manager = User.find(@user.manager_id)
      @products = @manager.products
      @sales = @user.sales
    end
  end

  def set_manager_id
    if params[:user][:manager_email] != ''
      if User.find_by(email: params[:user][:manager_email]) != nil
        return User.find_by(email: params[:user][:manager_email]).id
      else
        return nil
      end
    else
      return nil
    end
  end
end
