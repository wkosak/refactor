require 'rails_helper'

RSpec.describe "make episode as watched", :type => :request do
  it "mark episode as watched" do
    user = User.create!(:email => "foo@example.com", :password => "secret123")
    tv_show = TvShow.create!(user_id: user.id, title: 'SOA')
    ep1 = Episode.create!(episode: 1, tv_show_id: tv_show.id, watched: false)
    ep2 = Episode.create!(episode: 2, tv_show_id: tv_show.id, watched: false)
    tv_show.episodes << [ep1, ep2]

    post "/users/sign_in", user: {:email => "foo@example.com", :password => "secret123"}
    put "/tv_shows/#{tv_show.id}/episodes/#{ep1.id}", episode: { watched: true }, format: :json
    get "/tv_shows/#{tv_show.id}/episodes", format: :json

    expect(response.body).to include('true')
  end
end
