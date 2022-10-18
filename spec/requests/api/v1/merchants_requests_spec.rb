# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API' do
  describe 'Merchant Index' do
    let(:url) { '/api/v1' }
    context('Happy Path') do
      before(:each) { create_list(:merchant, 10) }

      it 'returns all merchants' do
        get "#{url}/merchants"
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        expect(merchants[:data].count).to eq 10
      end

      it 'merchant values are correct types' do
        get "#{url}/merchants"
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        merchants[:data].each do |merchant|
          expect(merchant.count).to eq 3
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(Integer)
          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_an(String)
          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_an(Hash)
          expect(merchant[:attributes][0]).to have_key(:name)
          expect(merchant[:attributes[0]].count).to eq 1
          expect(merchant[:attributes][0][:name]).to be_an(String)
        end
      end
    end

    context('Sad Path') do
      it 'returns array of data if no merchants found' do
        get "#{url}/merchants"
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants).to be_an(Array)
        expect(merchants.empty?).to be true
      end
    end
  end
end
