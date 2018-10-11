module ProductsHelper

  def set_price
    params[:product][:price].to_f
  end

  def set_commission
    params[:product][:commission].to_f / 100
  end

end
