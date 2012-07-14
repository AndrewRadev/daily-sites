class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    cookies.delete('remember_user_token')
    redirect_to login_page_path
  end
end
