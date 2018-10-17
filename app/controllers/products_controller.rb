class ProductsController < ApplicationController

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

end
