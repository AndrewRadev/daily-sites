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
    if Rails.env.development?
      @current_user ||= User.where(:name => 'Andrew').first
    else
      @current_user ||= begin
        User.find(session[:user_id]) if session[:user_id]
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
      end
    end
  end

  def logged_in?
    current_user.present?
  end
end
