FactoryBot.define do
  factory :message do
    number { Faker::Number.between(from: 1, to: 10000) }
    content { Faker::Lorem.sentence }
    chat_id { FactoryBot.create(:chat).id }
  end
end
