# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Show' do
  describe 'Item Show' do
    context('Happy Path') do
      let!(:load_object) { @item = create(:item) }
      let(:merchant) { @item.merchant }

      it 'returns correct items of given :id' do
        get api_v1_item_path(@item.id)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        item_response = JSON.parse(response.body, symbolize_names: true)[:data]
        # Check return length
        expect(item_response.count).to eq 3
        expect(item_response[:attributes].count).to eq 4

        expect(item_response).to have_key(:id)
        expect(item_response[:id]).to eq @item.id.to_s
        expect(item_response).to have_key(:type)
        expect(item_response[:type]).to be_an(String)
        expect(item_response).to have_key(:attributes)
        expect(item_response[:attributes]).to be_an(Hash)
        expect(item_response[:attributes]).to have_key(:name)
        expect(item_response[:attributes]).to have_key(:description)
        expect(item_response[:attributes]).to have_key(:unit_price)
        expect(item_response[:attributes]).to have_key(:merchant_id)
        expect(item_response.dig(:attributes, :name)).to eq @item.name
        expect(item_response.dig(:attributes, :description)).to eq @item.description
        expect(item_response.dig(:attributes, :unit_price)).to eq @item.unit_price
        expect(item_response.dig(:attributes, :merchant_id)).to eq @item.merchant_id
      end

      it 'returns merchant for given item :id' do
        get api_v1_item_merchant_index_path(@item.id)

        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)[:data]
        # Check return length
        expect(merchant_response.count).to eq 3
        expect(merchant_response[:attributes].count).to eq 1

        expect(merchant_response).to have_key(:id)
        expect(merchant_response[:id]).to eq merchant.id.to_s
        expect(merchant_response).to have_key(:type)
        expect(merchant_response[:type]).to be_an(String)
        expect(merchant_response).to have_key(:attributes)
        expect(merchant_response[:attributes]).to be_an(Hash)
        expect(merchant_response[:attributes]).to have_key(:name)
        expect(merchant_response.dig(:attributes, :name)).to eq merchant.name
      end
    end

    context('Edge Case') do
      it 'returns error message if :id is not found' do
        get api_v1_item_path(40)

        expect(response.successful?).to eq false
        expect(response).to have_http_status(404)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response.count).to eq 2
        expect(error_response).to have_key(:message)
        expect(error_response).to have_key(:errors)
        expect(error_response[:errors][0].count).to eq 3
        expect(error_response[:errors][0]).to have_key(:status)
        expect(error_response[:errors][0]).to have_key(:title)
        expect(error_response[:errors][0]).to have_key(:detail)
        expect(error_response[:errors][0][:status]).to eq '404'
        expect(error_response[:errors][0][:title]).to eq 'Not Found'
        expect(error_response[:errors][0][:detail]).to eq "Couldn't find Item with 'id'=40"
      end
    end
  end
end
