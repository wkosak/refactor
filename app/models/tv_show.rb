class TvShow < ActiveRecord::Base
  belongs_to :user
  has_many :episodes
end
