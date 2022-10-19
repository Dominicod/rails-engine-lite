# frozen_string_literal: true

RSpec.shared_examples 'item json' do |item, items, index|
  binding.pry
  expect(item.count).to eq 3
  expect(item[:attributes].count).to eq 4

  expect(item).to have_key(:id)
  expect(item[:id]).to eq items[index].id.to_s
  expect(item).to have_key(:type)
  expect(item[:type]).to be_an(String)
  expect(item).to have_key(:attributes)
  expect(item[:attributes]).to be_an(Hash)
  expect(item[:attributes]).to have_key(:name)
  expect(item[:attributes]).to have_key(:description)
  expect(item[:attributes]).to have_key(:unit_price)
  expect(item[:attributes]).to have_key(:merchant_id)
  expect(item.dig(:attributes, :name)).to eq items[index].name
  expect(item.dig(:attributes, :description)).to eq items[index].description
  expect(item.dig(:attributes, :unit_price)).to eq items[index].unit_price
  expect(item.dig(:attributes, :merchant_id)).to eq items[index].merchant_id
end
