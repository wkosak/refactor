require 'rails_helper'

RSpec.describe "make episode as watched", :type => :request do
  let(:user) { create(:user) }
  let(:tv_show) { create(:tv_show, user: user) }
  let(:ep1) { create(:episode, tv_show: tv_show) }

  it "mark episode as watched" do
    post "/users/sign_in", user: {:email => "foo@example.com", :password => "secret123"}

    put "/tv_shows/#{tv_show.id}/episodes/#{ep1.id}", episode: { watched: true }, format: :json

    # should to check is DB record updated (not a body content includes string 'true')
    expect(ep1.reload.watched).to be_truthy
  end
end
