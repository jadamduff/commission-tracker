class WelcomeController < ApplicationController

  def welcome
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

end
