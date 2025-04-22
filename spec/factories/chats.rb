FactoryBot.define do
  factory :chat do
    name { Faker::Company.name }
    number { 1 }
    application { FactoryBot.create(:application) }
  end
end
