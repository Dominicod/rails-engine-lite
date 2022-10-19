# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API | Find' do
  describe 'Merchant Find' do
    context('Happy Path') do
      before(:each) do
        create_list(:merchant, 10)
        @merchant = create(:merchant, name: 'boring')
        create(:merchant, name: 'thering')
        create(:merchant, name: 'ringbewildin')
      end

      it 'returns requested merchant with ?name param' do
        get api_v1_merchants_find_path(query: '?name=ring')
        expect(response).to be_successful
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_response[:data].count).to eq 1
      end

      it 'merchants values are correct types and values' do
        get api_v1_merchants_find_path(query: '?name=ring')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)

        merchant_response[:data].each do |merchant|
          # Check return length
          expect(merchant.count).to eq 3
          expect(merchant[:attributes].count).to eq 1

          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to eq @merchant.id
          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_an(String)
          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_an(Hash)
          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant.dig(:attributes, :name)).to eq @merchant.name
        end
      end
    end

    context('Sad Path') do
      it 'returns empty array if no merchants found' do
        get api_v1_merchants_find_path(query: '?name=ring')
        expect(response.successful?).to eq true
        expect(response).to have_http_status(200)

        merchant_response = JSON.parse(response.body, symbolize_names: true)

        expect(merchant_response).to be_an(Hash)
        expect(merchant_response[:data].empty?).to be true
      end
    end

    context('Edge Case') do
      # implement later
    end
  end
end
