class SessionsController < ApplicationController
  def create
    data = request.env['omniauth.auth']
    User.where(provider: data['provider'], uid: data['uid'], name: data['info']['name']).first_or_create
    render nothing: true
  end
end
