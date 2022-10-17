# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    status { 'shipped' }
    association :customer
    association :merchant

    trait :packaged do
      status { 'packaged' }
    end

    trait :returned do
      status { 'returned' }
    end

    factory :packaged_invoice, traits: [:packaged]
    factory :returned_invoice, traits: [:returned]
  end
end
