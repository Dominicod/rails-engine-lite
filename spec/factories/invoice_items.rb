# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..25) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    association :item
    association :invoice
  end
end
