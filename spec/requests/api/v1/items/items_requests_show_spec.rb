# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Show' do
  describe 'Item Show' do
    context('Happy Path') do
      before(:each) { create_list(:item, 10) }

      it 'returns correct item of given :id' do
        item_creation = create(:item)
        get api_v1_item_path(item_creation.id)
        expect(response.successful?).to eq true

        item = JSON.parse(response.body, symbolize_names: true)[:data][0]

        expect(item.count).to eq 3
        expect(item).to have_key(:id)
        expect(item[:id]).to eq item_creation.id
        expect(item).to have_key(:type)
        expect(item[:type]).to be_an(String)
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes].count).to eq 3
        expect(item.dig(:attributes, :name)).to eq item_creation.name
        expect(item.dig(:attributes, :description)).to eq item_creation.description
        expect(item.dig(:attributes, :unit_price)).to eq item_creation.unit_price
      end
    end

    context('Sad Path') do
      it 'returns error message if :id is not found' do
        get api_v1_item_path(40)

        expect(response.successful?).to eq false

        response = JSON.parse(response.body, symbolize: :names)
      end
    end
  end
end
