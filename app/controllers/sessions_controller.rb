class SessionsController < ApplicationController

  def new
  end

  def create
    if auth
      @user = User.find_or_create_by(email: auth['info']['email']) do |u|
        u.name = auth['info']['name']
        u.password = SecureRandom.urlsafe_base64
        u.manager = true
      end
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @user = User.find_by(email: params[:email])
      if (@user != nil) && (@user.authenticate(params[:password]))
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to login_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
