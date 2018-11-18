class UsersController < ApplicationController

  include UsersHelper

  before_action :require_login, only: [:show, :hot_products]
  before_action :set_form_variables, only: [:show, :hot_products]

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
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user, status: 200 }
    end
  end

  def sales
    @user = User.find(params[:id])
    @sales = @user.sales
    render json: @sales, satatus: 200
  end

end
