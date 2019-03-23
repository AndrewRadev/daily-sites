class ProfilesController < ApplicationController
  before_action :require_user

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(profile_params)
      redirect_to profile_path, notice: 'Your profile was updated.'
    else
      render action: :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to about_page_path, notice: 'Your account here has been deleted.'
  end

  private

  def profile_params
    params.require(:user).permit(
      :name,
      :time_zone
    )
  end
end
