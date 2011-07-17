class OmniauthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end
end
