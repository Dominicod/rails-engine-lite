# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchants API | Show' do
  describe 'Merchant Show' do
    context('Happy Path') do
      before(:each) { create_list(:merchant, 10) }

      it 'returns correct merchant of given :id' do
        merchant_creation = create(:merchant)
        api_v1_merchant_path(merchant.id)
        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(merchant.count).to eq 3
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to eq merchant_creation.id
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_an(String)
        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes].count).to eq 1
        expect(merchant.dig(:attributes, :name)).to eq merchant_creation.name
      end
    end

    context('Sad Path') do
      it 'returns error message if :id is not found' do
        api_v1_merchant_path(merchant.id)
        expect(response).to_not be_success

        response = JSON.parse(response.body, symbolize: :names)
      end
    end
  end
end
