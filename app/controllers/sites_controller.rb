class SitesController < ApplicationController
  before_filter :require_user

  def index
    @now   = DateTime.now.in_time_zone(current_user.time_zone)
    @sites = current_user.sites.for_day(@now)
    @title = "Sites for today"
  end

  def all
    @now   = DateTime.now.in_time_zone(current_user.time_zone)
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
end
