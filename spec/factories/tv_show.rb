FactoryBot.define do
  factory :tv_show do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentences }
    rank { rand(5) + 1 }
    user
  end
end
