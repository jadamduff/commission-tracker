class UsersController < ApplicationController

  include UsersHelper

  before_action :require_login, only: [:show]

  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password], manager: params[:user][:manager])
    @user.manager_id = set_manager_id
    if @user.save
      if !@user.is_manager?
        User.find(set_manager_id).employees << @user
      end
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'welcome/welcome'
    end
  end

  def show
    @user = User.find(params[:id])
    set_show_variables
    valid_page_view
  end

end
