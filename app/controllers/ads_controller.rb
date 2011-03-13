class AdsController < ApplicationController
  def index
    @ads = Ad.all
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
    if logged_in?
      @ad.name = current_user.name
      @ad.email = current_user.email
    end
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def create
    params[:ad][:user_id] = current_user.id if logged_in?
    @ad = Ad.new(params[:ad])

    render(:action => "new") unless @ad.save
    self.current_user = @ad.user unless logged_in?
  end

  def update
    params[:ad][:user_id] = current_user.id if logged_in?
    @ad = Ad.find(params[:id])

    render(:action => "edit") unless @ad.update_attributes(params[:ad])
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    redirect_to(ads_url)
  end
end
