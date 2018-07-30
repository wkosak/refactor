# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

3.times do |i|
  email = "user#{i}@example.com"
  User.create(
      email: email,
      password: "password"
  )
end

10.times do |i|
  tv_show = TvShow.create(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.sentences,
      rank: rand(5)+1
  )
  tv_show.episodes.create title: 'Episode 1', episode: 1, watched: false
end


