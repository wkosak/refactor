require 'rails_helper'

RSpec.describe TvShowsController, :type => :controller do

  before  { sign_in :user, create(:user) }

  describe "GET #index" do
    let!(:tv_shows) { create_list(:tv_show, 3) }

    it "responds successfully with an HTTP 200 status code" do
      get :index, :format => :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the tv_shows into @tv_shows" do
      get :index, :format => :json

      expect(assigns(:tv_shows)).to match_array(tv_shows)
    end
  end

  describe "GET #show" do
    let(:tv_show) { TvShow.create! }

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: tv_show.id, :format => :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the tv_shows into @tv_shows" do
      get :show, id: tv_show.id, :format => :json

      expect(assigns(:tv_show)).to match(tv_show)
    end

    it 'incude episodes data in response' do
      ep1 = Episode.create!(episode: 1, tv_show_id: tv_show.id)
      ep2 = Episode.create!(episode: 2, tv_show_id: tv_show.id)
      get :show, id: tv_show.id, :format => :json

      expect(JSON.parse(response.body)).to have_key('episodes')
      expect(JSON.parse(response.body)['episodes']).to be_an(Array)
      expect(response.body).to match(/#{tv_show.id}/)
    end
  end

  describe "POST #create" do
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      post :create, tv_show: params

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "respond with created tv show" do
      request.accept = "application/json"
      post :create, tv_show: params

      expect(response.body).to include('House')
    end
  end

  describe "PUT #update" do
    let(:tv_show) { TvShow.create!(title: 'Foo') }
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      put :update, id: tv_show.id, tv_show: params

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "respond with updated tv show" do
      request.accept = "application/json"
      put :update, id: tv_show.id, tv_show: params

      expect(response.body).to include('House')
    end
  end

  describe 'DELETE #destroy' do
    let(:tv_show) { TvShow.create!(title: 'House') }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      delete :destroy, id: tv_show.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "respond with deleted tv show" do
      request.accept = "application/json"
      delete :destroy, id: tv_show.id

      expect(response.body).to include('House')
    end
  end
end
