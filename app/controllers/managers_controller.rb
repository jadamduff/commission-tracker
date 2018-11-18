class ManagersController < ApplicationController

  before_action :require_login, only: [:show]
  before_action :set_form_variables, only: [:show]

  include ManagersHelper

  def show
    if !User.find(params[:user_id]).is_manager?
      @user = User.find(User.find(params[:user_id]).manager_id)
      set_show_variables
      valid_page_view
    else
      redirect_to user_path(current_user)
    end
  end

end
