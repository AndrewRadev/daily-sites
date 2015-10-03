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

  def daily
    day    = params[:day].to_i
    @sites = current_user.sites.for_day(day)
    @title = "Sites for #{Site::DayNames[day]}"

    render :index
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site      = Site.new(site_params)
    @site.user = current_user

    if @site.save
      redirect_to root_path, :notice => 'Site was successfully created.'
    else
      render :action => :new
    end
  end

  def update
    @site = Site.find(params[:id])

    if @site.update_attributes(site_params)
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

  def site_params
    params.require(:site).permit(
      :url, :title,
      :monday, :tuesday, :wednesday, :thursday, :friday,
      :saturday, :sunday
    )
  end
end
