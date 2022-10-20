# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Find' do
  describe 'Item Find' do
    context('Happy Path') do
      before(:each) do
        @item_1 = create(:item, name: 'boring', unit_price: 50.00)
        @item_2 = create(:item, name: 'ringmates', unit_price: 120.50)
        @item_3 = create(:item, name: 'The Ring Store', unit_price: 10.11)
        @item_4 = create(:item, name: "Dominic's Shop", unit_price: 25.25)
        @item_5 = create(:item, name: 'Unlimited Creativity', unit_price: 101.00)
      end

      context 'Name Parameter' do
        it 'returns all items with given name param' do
          get api_v1_items_find_all_path(name: 'ring')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          expect(items_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_all_path(name: 'ring')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          items = [@item_3, @item_1, @item_2]

          items_response[:data].each_with_index do |item, index|
            # Check return length
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
        end
      end

      context 'Minimum Price Parameter' do
        it 'returns all items with given min_price param' do
          get api_v1_items_find_all_path(min_price: '50')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          expect(items_response[:data].count).to eq 3
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_all_path(min_price: '50')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          items = [@item_5, @item_1, @item_2]

          items_response[:data].each_with_index do |item, index|
            # Check return length
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
        end
      end

      context 'Maximum Price Parameter' do
        it 'returns all items with given max_price param' do
          get api_v1_items_find_all_path(max_price: '101.00')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          expect(items_response[:data].count).to eq 4
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_all_path(max_price: '101.00')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          items = [@item_4, @item_3, @item_5, @item_1]

          items_response[:data].each_with_index do |item, index|
            # Check return length
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
        end
      end

      context 'Maximum + Minimum Price Parameter' do
        it 'returns all items with given min_price param' do
          get api_v1_items_find_all_path(min_price: '50', max_price: '101.00')
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          expect(items_response[:data].count).to eq 2
        end

        it 'items values are correct types and values' do
          get api_v1_items_find_all_path(min_price: '50', max_price: '101.00')
          expect(response.successful?).to eq true
          expect(response).to have_http_status(200)

          items_response = JSON.parse(response.body, symbolize_names: true)
          items = [@item_5, @item_1]

          items_response[:data].each_with_index do |item, index|
            # Check return length
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
        end
      end
    end

    context('Sad Path') do
      it 'returns empty array if no items found for name param' do
        get api_v1_items_find_all_path(name: 'ring')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(items_response).to be_an(Hash)
        expect(items_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for min_price param' do
        get api_v1_items_find_all_path(min_price: '50')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(items_response).to be_an(Hash)
        expect(items_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for max_price param' do
        get api_v1_items_find_all_path(max_price: '101')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(items_response).to be_an(Hash)
        expect(items_response[:data].empty?).to be true
      end

      it 'returns empty array if no items found for min_max_price param' do
        get api_v1_items_find_all_path(min_price: '50', max_price: '101')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(items_response).to be_an(Hash)
        expect(items_response[:data].empty?).to be true
      end
    end

    context 'Edge Case' do
      before(:each) do
        @item_1 = create(:item, name: 'boring')
        @item_2 = create(:item, name: 'ringmates')
        @item_3 = create(:item, name: 'The Ring Store')
        @item_4 = create(:item, name: "Dominic's Shop")
        @item_5 = create(:item, name: 'Unlimited Creativity')
      end

      it 'throws an error if name and min_price are sent' do
        get api_v1_items_find_all_path(name: 'ring', min_price: '50')
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
        expect(error_response[:errors][0][:detail]).to eq 'Cannot have name params and price params'
      end

      it 'throws an error if name and max_price are sent' do
        get api_v1_items_find_all_path(name: 'ring', max_price: '100')
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
        expect(error_response[:errors][0][:detail]).to eq 'Cannot have name params and price params'
      end

      it 'throws an error if name, min_price, and max_price are sent' do
        get api_v1_items_find_all_path(name: 'ring', min_price: '50', max_price: '100')
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
        expect(error_response[:errors][0][:detail]).to eq 'Cannot have name params and price params'
      end
    end
  end
end
