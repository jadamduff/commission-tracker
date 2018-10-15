class SalesController < ApplicationController

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      current_user.sales << @sale
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity)
  end

end
