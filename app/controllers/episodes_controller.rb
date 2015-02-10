class EpisodesController < ApplicationController
  def index
    @tv_show = TvShow.find(params[:tv_show_id])
    @episodes = Episode.where(tv_show_id: @tv_show.id)
    respond_to do |format|
      format.json { render :json => @episodes }
    end
  end

  def show
    @tv_show = TvShow.find(params[:tv_show_id])
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    respond_to do |format|
      format.json { render :json => @episode }
    end
  end

  def create
    @tv_show = TvShow.find(params[:tv_show_id])
    @episode = Episode.new(episode_params)
    @episode.tv_show_id = @tv_show.id
    if @episode.save
      respond_to do |format|
        format.json { render :json => @episode }
      end
    end
  end

  def update
    @tv_show = TvShow.find(params[:tv_show_id])
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    if @episode.update_attributes(episode_params)
      respond_to do |format|
        format.json { render :json => @episode }
      end
    end
  end

  def destroy
    @tv_show = TvShow.find(params[:tv_show_id])
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    @episode.delete
    respond_to do |format|
      format.json { render :json => @episode }
    end
  end

  private
  def episode_params
    params.require('episode').permit('title')
  end
end
