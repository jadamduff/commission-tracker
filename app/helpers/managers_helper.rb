module ManagersHelper

  def valid_page_view
    if !is_managers_profile?
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end

  def set_show_variables
    @employees = @user.employees
    @products = Product.where('manager_id = ?', @user.id)
  end

end
