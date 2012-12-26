class SessionsController < ApplicationController
  def backdoor
    if params[:id]
      user = User.find(params[:id])
    else
      user = User.first
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    cookies.delete('remember_user_token')
    redirect_to login_page_path
  end
end
