# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API | Show' do
  describe 'Merchant Show' do
    context('Happy Path') do
      before(:each) { @merchant = create(:merchant) }

      it 'returns correct merchants of given :id' do
        get api_v1_merchant_path(@merchant.id)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)[:data]
        # Check return length
        expect(merchant_response.count).to eq 3
        expect(merchant_response[:attributes].count).to eq 1

        expect(merchant_response).to have_key(:id)
        expect(merchant_response[:id]).to eq @merchant.id.to_s
        expect(merchant_response).to have_key(:type)
        expect(merchant_response[:type]).to be_an(String)
        expect(merchant_response).to have_key(:attributes)
        expect(merchant_response[:attributes]).to be_an(Hash)
        expect(merchant_response[:attributes]).to have_key(:name)
        expect(merchant_response.dig(:attributes, :name)).to eq @merchant.name
      end

      it 'returns items for given merchants :id' do
        items = create_list(:item, 3, merchant: @merchant)
        get api_v1_merchant_items_path(@merchant.id)

        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)[:data]
        # Check return length
        expect(items.count).to eq 3

        items_response.each_with_index do |item, index|
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
      end
    end

    context('Edge Case') do
      it 'returns error message if :id is not found' do
        get api_v1_merchant_path(40)
        expect(response.successful?).to eq false
        # expect(response).to have_http_status()

        item_response = JSON.parse(response.body, symbolize_names: true)
      end
    end

    context('Sad Path') do
      before(:each) { @merchant = create(:merchant) }

      it 'returns empty array if no items found' do
        get api_v1_merchant_items_path(@merchant.id)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(items_response).to be_an(Hash)
        expect(items_response[:data].empty?).to be true
      end
    end
  end
end
