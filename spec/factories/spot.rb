FactoryBot.define do
  factory :spot do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { (1..10).to_a.sample }
    images { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/image1.webp'))) }
  end
end