# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API | Index' do
  describe 'Merchant Index' do
    context('Happy Path') do
      before(:each) { create_list(:merchant, 10) }

      it 'returns all merchants' do
        get api_v1_merchants_path
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        expect(merchants[:data].count).to eq 10
      end

      it 'merchant values are correct types' do
        get api_v1_merchants_path
        expect(response.successful?).to eq true

        merchants = JSON.parse(response.body, symbolize_names: true)

        merchants[:data].each do |merchant|
          # Check return length
          expect(merchant.count).to eq 3
          expect(merchant[:attributes].count).to eq 1

          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)
          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_an(String)
          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_an(Hash)
          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant.dig(:attributes, :name)).to be_an(String)
        end
      end
    end

    context('Sad Path') do
      it 'returns array of data if no merchants found' do
        get api_v1_merchants_path
        expect(response.successful?).to eq true

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants).to be_an(Hash)
        expect(merchants[:data].empty?).to be true
      end
    end
  end
end
