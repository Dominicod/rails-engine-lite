# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Create' do
  describe 'Item Create' do
    context('Happy Path') do
      let(:merchant) { create(:merchant) }
      
      it 'creates a new item' do
        item_params = {
          name: 'Ruby',
          description: 'Does cool things',
          unit_price: 99.99,
          merchant_id: merchant.id
        }
        headers = { content_type: 'application/json' }

        post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

        item = Item.last

        expect(response.successful?).to eq true
        expect(response).to have_http_status(201)

        item_response = JSON.parse(response, symbolize_names: true)

        expect(item_response.count).to eq 3
        expect(item_response[:attributes].count).to eq 4

        expect(item_response).to have_key(:id)
        expect(item_response[:id]).to eq item.id.to_s
        expect(item_response).to have_key(:type)
        expect(item_response[:type]).to be_an(String)
        expect(item_response).to have_key(:attributes)
        expect(item_response[:attributes]).to be_an(Hash)
        expect(item_response[:attributes]).to have_key(:name)
        expect(item_response[:attributes]).to have_key(:description)
        expect(item_response[:attributes]).to have_key(:unit_price)
        expect(item_response[:attributes]).to have_key(:merchant_id)
        expect(item_response.dig(:attributes, :name)).to eq item.name
        expect(item_response.dig(:attributes, :description)).to eq item.description
        expect(item_response.dig(:attributes, :unit_price)).to eq item.unit_price
        expect(item_response.dig(:attributes, :merchant_id)).to eq item.merchant_id
      end
    end

    context('Edge Case') do
      xit 'returns error message if incorrect attributes used/missing attributes' do
        item_params = {
          name: 'Ruby',
          description: 'Does cool things',
          merchant_id: merchant.id
        }
        headers = { content_type: 'application/json' }

        post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
        expect(response.successful?).to eq false
        # expect(response).to have_http_status(201)
      end
    end
  end
end
