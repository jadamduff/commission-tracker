module ProductsHelper

  def set_price
    params[:product][:price] != '' ? params[:product][:price].to_f : nil
  end

  def set_commission
    params[:product][:commission] != '' ? params[:product][:commission].to_f / 100 : nil
  end

end
