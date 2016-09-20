class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: "Welcome #{user.name}, you are now logged in."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are now logged out."
  end
end
