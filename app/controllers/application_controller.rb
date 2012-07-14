class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  private

  def require_user
    if not logged_in?
      redirect_to login_page_path
    end
  end

  def current_user
    @current_user ||= find_current_user
  end

  def logged_in?
    current_user.present?
  end

  def find_current_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif cookies.signed['remember_user_token']
      user = User.serialize_from_cookie(cookies.signed['remember_user_token'])
      session[:user_id] = user.id
      user
    end
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    cookies.delete('remember_user_token')
  end
end
