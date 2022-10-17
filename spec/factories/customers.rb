# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.unique.first_name }
    first_name { Faker::Name.unique.last_name }
  end
end
