# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::ProgrammingLanguage.name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    association :merchant
  end
end
