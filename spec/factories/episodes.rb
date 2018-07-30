FactoryBot.define do
  factory :episode do
    title { Faker::Lorem.word }
    tv_show
    episode { 1 }
    watched { true }
  end
end
