class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_tv_show

  def index
    @episodes = @tv_show.episodes
    respond_to do |format|
      format.json { render :json => @episodes }
    end
  end

  def show
    @episode = @tv_show.episodes.find params[:id]
    respond_to do |format|
      format.json { render :json => @episode }
    end
  end

  def create
    @episode = @tv_show.episodes.new(episode_params)
    if @episode.save
      respond_to do |format|
        format.json { render :json => @episode }
      end
    end
  end

  def update
    @episode = @tv_show.episodes.find params[:id]
    if @episode.update_attributes(episode_params)
      respond_to do |format|
        format.json { render :json => @episode }
      end
    end
  end

  def destroy
    @episode = @tv_show.episodes.find params[:id]
    @episode.delete
    respond_to do |format|
      format.json { render :json => @episode }
    end
  end

  private

  def load_tv_show
    @tv_show = TvShow.find(params[:tv_show_id])
  end

  def episode_params
    params.require('episode').permit('title', 'watched')
  end
end
