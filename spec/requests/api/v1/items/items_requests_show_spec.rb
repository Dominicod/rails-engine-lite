# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Show' do
  describe 'Item Show' do
    context('Happy Path') do
      before(:each) { @item = create(:item) }

      it 'returns correct items of given :id' do
        get api_v1_item_path(@item.id)
        expect(response.successful?).to eq true

        item = JSON.parse(response.body, symbolize_names: true)[:data]
        # Check return length
        expect(item.count).to eq 3
        expect(item[:attributes].count).to eq 4

        expect(item).to have_key(:id)
        expect(item[:id]).to eq @item.id.to_s
        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item.dig(:attributes, :name)).to eq @item.name
        expect(item.dig(:attributes, :description)).to eq @item.description
        expect(item.dig(:attributes, :unit_price)).to eq @item.unit_price
        expect(item.dig(:attributes, :merchant_id)).to eq @item.merchant_id
      end
    end

    context('Edge Case') do
      xit 'returns error message if :id is not found' do
        get api_v1_item_path(40)

        expect(response.successful?).to eq false

        response = JSON.parse(response.body, symbolize_names: true)
      end
    end

    context('Sad Path') do
      it 'returns empty array if no merchant found' do
        item_creation = create(:item, merchant: nil)
        get api_v1_item_merchants_path(item_creation.id)
        expect(response.successful?).to eq true

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(merchant).to be_an(Hash)
        expect(merchant[:data].empty?).to be true
      end
    end
  end
end
