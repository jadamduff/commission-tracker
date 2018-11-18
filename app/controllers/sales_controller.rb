class SalesController < ApplicationController

  before_action :require_login, only: [:show, :new, :create, :update]

  def new
    redirect_to user_path(current_user) unless !current_user.is_manager?
    @sale = Sale.new
    @manager_products = Product.where('manager_id = ?', current_user.manager_id)
  end

  def create
    redirect_to user_path(current_user) unless !current_user.is_manager?
    @sale = Sale.new
    @sale.quantity = params[:sale][:quantity]
    @sale.product_id = params[:sale][:product_id]
    @sale.user_id = current_user.id
    if @sale.save
      render json: @sale, status: 201
    else
      render json: { errors: @sale.errors }
    end
  end

  def show
    redirect_to user_path(current_user) unless current_user.sales.include?(Sale.find(params[:id])) && !current_user.is_manager?
    @user = User.find(params[:user_id])
    @sale = Sale.find(params[:id])
    @manager_products = Product.where('manager_id = ?', current_user.manager_id)
  end

  def data
    if current_user.sales.include?(Sale.find(params[:id])) && !current_user.is_manager?
      @sale = Sale.find(params[:id])
      render json: @sale, status: 200
    end
  end

  def update
    @sale = Sale.find(params[:id])
    @sale.product_id = params[:sale][:product_id]
    @sale.quantity = params[:sale][:quantity]
    if @sale.save
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:user_id])
      render 'show'
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    if current_user.id == params[:user_id].to_i
      @sale.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def by_quantity
    @sales = Sale.display_by_quantity
  end

end
