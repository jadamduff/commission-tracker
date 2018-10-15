class SalesController < ApplicationController

  def new
    redirect_to user_path(current_user) unless !current_user.is_manager?
    @sale = Sale.new
    @manager_products = Product.where('manager_id = ?', current_user.manager_id)
  end

  def create
    redirect_to user_path(current_user) unless !current_user.is_manager
    @sale = Sale.new
    @sale.quantity = params[:sale][:quantity]
    @sale.product_id = params[:sale][:product_id]
    @sale.user_id = current_user.id
    if @sale.save
      redirect_to user_path(current_user)
    else
      @manager_products = Product.where('manager_id = ?', current_user.manager_id)
      render 'new'
    end
  end

  def show

  end

  def edit

  end

end
