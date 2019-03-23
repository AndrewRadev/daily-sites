class ApplicationController < ActionController::Base
  private

  def require_user
    redirect_to login_page_path if not logged_in?
  end

  def current_user
    @current_user ||= find_current_user
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

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

  def current_time
    DateTime.now.in_time_zone(current_user.time_zone)
  end
  helper_method :current_time
end
