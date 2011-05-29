class SitesController < ApplicationController
  before_filter :require_user

  def index
    @now   = DateTime.now
    @sites = current_user.sites.for_day(@now)
  end

  def all
    @sites = Site.all
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
