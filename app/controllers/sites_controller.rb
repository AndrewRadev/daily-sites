class SitesController < ApplicationController
  before_filter :require_user

  def index
    @sites = current_user.sites.for_time(current_time)
    @title = "Sites for today"
  end

  def all
    @sites = current_user.sites
    @title = "All sites"
    render :index
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(params[:site])

    if @site.save
      redirect_to root_path, :notice => 'Site was successfully created.'
    else
      render :action => :new
    end
  end

  def update
    @site = Site.find(params[:id])

    if @site.update_attributes(params[:site])
      redirect_to root_path, :notice => 'Site was successfully updated.'
    else
      render :action => :edit
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    redirect_to root_path
  end

  private

  def current_time
    DateTime.now.in_time_zone(current_user.time_zone)
  end
  helper_method :current_time
end
