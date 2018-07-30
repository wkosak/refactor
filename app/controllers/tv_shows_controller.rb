class TvShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_access, only: [:update, :destroy]

  def index
    @tv_shows = TvShow.all
    respond_to do |format|
      format.json { render :json => @tv_shows }
    end
  end

  def show
    @tv_show = TvShow.find(params[:id])
    respond_to do |format|
      format.json { render :json => @tv_show }
    end
  end

  def create
    @tv_show = TvShow.new(tv_show_params)
    @tv_show.user_id = current_user.id
    if @tv_show.save
      respond_to do |format|
        format.json { render :json => @tv_show }
      end
    end
  end

  def update
    if @tv_show.update_attributes(tv_show_params)
      respond_to do |format|
        format.json { render :json => @tv_show }
      end
    end
  end

  def destroy
    @tv_show.destroy
    respond_to do |format|
      format.json { render :json => @tv_show }
    end
  end

  private

  def tv_show_params
    params.require('tv_show').permit('title')
  end

  def check_access
    @tv_show = TvShow.find(params[:id])
    return head(:forbidden) unless TvShowPolicy.new(current_user, @tv_show).can_change?
  end
end
