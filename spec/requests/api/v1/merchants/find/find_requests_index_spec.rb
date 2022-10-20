# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API | Find' do
  describe 'Merchant Find' do
    context('Happy Path') do
      let!(:load_objects) do
        create_list(:merchant, 10)
        @merchant = create(:merchant, name: 'aring')
        create(:merchant, name: 'thering')
        create(:merchant, name: 'ringbewildin')
      end

      it 'returns requested merchant with ?name param' do
        get api_v1_merchants_find_path(name: 'ring')
        expect(response).to be_successful
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_response[:data].count).to eq 3
      end

      it 'merchants values are correct types and values' do
        get api_v1_merchants_find_path(name: 'ring')
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
    end

    context('Sad Path') do
      it 'returns empty array if no merchants found' do
        get api_v1_merchants_find_path(name: 'ring')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)

        expect(merchant_response).to be_an(Hash)
        expect(merchant_response[:data].empty?).to be true
      end
    end

    context('Edge Case') do
      it 'throws an error if param is not present' do
        get api_v1_merchants_find_path
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
        expect(error_response[:errors][0][:detail]).to eq 'param is missing or the value is empty: name'
      end

      it 'throws an error if param is empty' do
        get api_v1_merchants_find_path(name: '')
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
        expect(error_response[:errors][0][:detail]).to eq 'param is missing or the value is empty: name'
      end
    end
  end
end
