FactoryBot.define do
  factory :review do
    name { Faker::Lorem.sentence }
    comment { Faker::Lorem.paragraph }
    point { (1..5).to_a.sample }
    spot { Spot.first || association(:spot) }
  end
end