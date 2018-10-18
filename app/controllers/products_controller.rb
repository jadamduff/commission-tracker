class ProductsController < ApplicationController

  before_action :require_login, only: [:show, :new, :create, :update]

  include ProductsHelper

  def new
    redirect_to user_path(current_user) unless current_user.is_manager?
    @js = ['products_form']
    @product = Product.new
  end

  def create
    redirect_to user_path(current_user) unless current_user.is_manager?
    @product = Product.new
    @product.title = params[:product][:title]
    @product.price = set_price
    @product.commission = set_commission
    @product.color = params[:product][:color]
    @product.manager_id = current_user.id
    if @product.save
      redirect_to user_path(current_user)
    else
      @js = ['products_form']
      render 'new'
    end
  end

  def show
    redirect_to user_path(current_user) unless current_user.manager_products.include?(Product.find(params[:id])) && current_user.is_manager?
    @js = ['products_form']
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.title = params[:product][:title]
    @product.price = set_price
    @product.commission = set_commission
    @product.color = params[:product][:color]
    if @product.save
      redirect_to user_path(current_user)
    else
      @js = ['products_form']
      @user = User.find(params[:user_id])
      render 'show'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if current_user.id == params[:user_id].to_i
      Sale.where('product_id = ?', @product.id).destroy_all
      @product.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def hot_products
    redirect_to user_path(current_user) unless current_user.is_manager?
    @user = current_user
    @products = Product.list_hot_products(current_user.id)
  end

end
