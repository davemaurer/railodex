class SessionsController < ApplicationController
  def create
    data = request.env['omniauth.auth']
    User.create(provider: data['provider'], uid: data['uid'], name: data['info']['name'])
    render nothing: true
  end
end
