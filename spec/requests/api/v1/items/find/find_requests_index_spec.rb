# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Find' do
  describe 'Item Find' do
    context('Happy Path') do
      let!(:load_objects) do
        @item_1 = create(:item, name: 'boring', unit_price: 50.00)
        @item_2 = create(:item, name: 'ringmates', unit_price: 120.50)
        @item_3 = create(:item, name: 'The Ring Store', unit_price: 10.11)
        @item_4 = create(:item, name: "Dominic's Shop", unit_price: 25.25)
        @item_5 = create(:item, name: 'Unlimited Creativity', unit_price: 101.00)
      end

      context 'Name Parameter' do
        it 'returns item with given name param' do
          get api_v1_items_find_path(name: 'ring')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)
          expect(item_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_path(name: 'ring')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)[:data]

          # Check return length
          expect(item_response.count).to eq 3
          expect(item_response[:attributes].count).to eq 4

          expect(item_response).to have_key(:id)
          expect(item_response[:id]).to eq @item_3.id.to_s
          expect(item_response).to have_key(:type)
          expect(item_response[:type]).to be_an(String)
          expect(item_response).to have_key(:attributes)
          expect(item_response[:attributes]).to be_an(Hash)
          expect(item_response[:attributes]).to have_key(:name)
          expect(item_response[:attributes]).to have_key(:description)
          expect(item_response[:attributes]).to have_key(:unit_price)
          expect(item_response[:attributes]).to have_key(:merchant_id)
          expect(item_response.dig(:attributes, :name)).to eq @item_3.name
          expect(item_response.dig(:attributes, :description)).to eq @item_3.description
          expect(item_response.dig(:attributes, :unit_price)).to eq @item_3.unit_price
          expect(item_response.dig(:attributes, :merchant_id)).to eq @item_3.merchant_id
        end
      end

      context 'Minimum Price Parameter' do
        it 'returns item with given min_price param' do
          get api_v1_items_find_path(min_price: '60')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)
          expect(item_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_path(min_price: '60')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)[:data]

          # Check return length
          expect(item_response.count).to eq 3
          expect(item_response[:attributes].count).to eq 4

          expect(item_response).to have_key(:id)
          expect(item_response[:id]).to eq @item_5.id.to_s
          expect(item_response).to have_key(:type)
          expect(item_response[:type]).to be_an(String)
          expect(item_response).to have_key(:attributes)
          expect(item_response[:attributes]).to be_an(Hash)
          expect(item_response[:attributes]).to have_key(:name)
          expect(item_response[:attributes]).to have_key(:description)
          expect(item_response[:attributes]).to have_key(:unit_price)
          expect(item_response[:attributes]).to have_key(:merchant_id)
          expect(item_response.dig(:attributes, :name)).to eq @item_5.name
          expect(item_response.dig(:attributes, :description)).to eq @item_5.description
          expect(item_response.dig(:attributes, :unit_price)).to eq @item_5.unit_price
          expect(item_response.dig(:attributes, :merchant_id)).to eq @item_5.merchant_id
        end
      end

      context 'Maximum Price Parameter' do
        it 'returns item with given max_price param' do
          get api_v1_items_find_path(max_price: '101.00')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)
          expect(item_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_path(max_price: '101.00')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)[:data]

          # Check return length
          expect(item_response.count).to eq 3
          expect(item_response[:attributes].count).to eq 4

          expect(item_response).to have_key(:id)
          expect(item_response[:id]).to eq @item_4.id.to_s
          expect(item_response).to have_key(:type)
          expect(item_response[:type]).to be_an(String)
          expect(item_response).to have_key(:attributes)
          expect(item_response[:attributes]).to be_an(Hash)
          expect(item_response[:attributes]).to have_key(:name)
          expect(item_response[:attributes]).to have_key(:description)
          expect(item_response[:attributes]).to have_key(:unit_price)
          expect(item_response[:attributes]).to have_key(:merchant_id)
          expect(item_response.dig(:attributes, :name)).to eq @item_4.name
          expect(item_response.dig(:attributes, :description)).to eq @item_4.description
          expect(item_response.dig(:attributes, :unit_price)).to eq @item_4.unit_price
          expect(item_response.dig(:attributes, :merchant_id)).to eq @item_4.merchant_id
        end
      end

      context 'Maximum + Minimum Price Parameter' do
        it 'returns all items with given min_price param' do
          get api_v1_items_find_path(min_price: '10', max_price: '30')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          expect(items_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_path(min_price: '50', max_price: '101.00')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          item_response = JSON.parse(response.body, symbolize_names: true)[:data]

          # Check return length
          expect(item_response.count).to eq 3
          expect(item_response[:attributes].count).to eq 4

          expect(item_response).to have_key(:id)
          expect(item_response[:id]).to eq @item_5.id.to_s
          expect(item_response).to have_key(:type)
          expect(item_response[:type]).to be_an(String)
          expect(item_response).to have_key(:attributes)
          expect(item_response[:attributes]).to be_an(Hash)
          expect(item_response[:attributes]).to have_key(:name)
          expect(item_response[:attributes]).to have_key(:description)
          expect(item_response[:attributes]).to have_key(:unit_price)
          expect(item_response[:attributes]).to have_key(:merchant_id)
          expect(item_response.dig(:attributes, :name)).to eq @item_5.name
          expect(item_response.dig(:attributes, :description)).to eq @item_5.description
          expect(item_response.dig(:attributes, :unit_price)).to eq @item_5.unit_price
          expect(item_response.dig(:attributes, :merchant_id)).to eq @item_5.merchant_id
        end
      end
    end

    context('Sad Path') do
      it 'returns empty array if no items found for name param' do
        get api_v1_items_find_path(name: 'ring')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        item_response = JSON.parse(response.body, symbolize_names: true)

        expect(item_response).to be_an(Hash)
        expect(item_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for min_price param' do
        get api_v1_items_find_path(min_price: '50')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        item_response = JSON.parse(response.body, symbolize_names: true)

        expect(item_response).to be_an(Hash)
        expect(item_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for max_price param' do
        get api_v1_items_find_path(max_price: '101')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        item_response = JSON.parse(response.body, symbolize_names: true)

        expect(item_response).to be_an(Hash)
        expect(item_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for min_max_price param' do
        get api_v1_items_find_path(min_price: '50', max_price: '101')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        item_response = JSON.parse(response.body, symbolize_names: true)

        expect(item_response).to be_an(Hash)
        expect(item_response[:data].empty?).to be true
      end
    end

    context 'Edge Case' do
      let!(:load_objects) do
        @item_1 = create(:item, name: 'boring', unit_price: 50.00)
        @item_2 = create(:item, name: 'ringmates', unit_price: 120.50)
        @item_3 = create(:item, name: 'The Ring Store', unit_price: 10.11)
        @item_4 = create(:item, name: "Dominic's Shop", unit_price: 25.25)
        @item_5 = create(:item, name: 'Unlimited Creativity', unit_price: 101.00)
      end

      it 'throws an error if no params present' do
        get api_v1_items_find_path
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Incorrect usage of params'
      end

      it 'throws an error if name and min_price are sent' do
        get api_v1_items_find_path(name: 'ring', min_price: '50')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Incorrect usage of params'
      end

      it 'throws an error if name and max_price are sent' do
        get api_v1_items_find_path(name: 'ring', max_price: '100')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Incorrect usage of params'
      end

      it 'throws an error if name, min_price, and max_price are sent' do
        get api_v1_items_find_path(name: 'ring', min_price: '50', max_price: '100')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Incorrect usage of params'
      end

      it 'throws an error if min_price is negative' do
        get api_v1_items_find_path(min_price: '-5')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Price cannot be less than zero'
      end

      it 'throws an error if max_price is negative' do
        get api_v1_items_find_path(max_price: '-5')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Price cannot be less than zero'
      end

      it 'throws an error if min_price is more than max_price' do
        get api_v1_items_find_path(max_price: '50', min_price: '100')
        expect(response.successful?).to eq false
        expect(response).to have_http_status(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '400'
        expect(error_response[:errors][0][:title]).to eq 'Bad Request'
        expect(error_response[:errors][0][:detail]).to eq 'Pricing Invalid'
      end
    end
  end
end
