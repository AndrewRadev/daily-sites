class ProfilesController < ApplicationController
  before_filter :require_user

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to profile_path, :notice => 'Your profile was updated.'
    else
      render :action => :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to about_page_path, :notice => 'Your account here has been deleted.'
  end
end
