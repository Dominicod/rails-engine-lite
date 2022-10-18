# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Index' do
  describe 'Item Index' do
    context('Happy Path') do
      before(:each) { create_list(:item, 10) }

      it 'returns all items' do
        get api_v1_items_path
        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)
        expect(items[:data].count).to eq 10
      end

      it 'item values are correct types' do
        get api_v1_items_path
        expect(response.successful?).to eq true

        items = JSON.parse(response.body, symbolize_names: true)

        items[:data].each do |item|
          expect(item.count).to eq 3
          expect(item).to have_key(:id)
          expect(item[:id]).to be_an(Integer)
          expect(item).to have_key(:type)
          expect(item[:type]).to be_an(String)
          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_an(Hash)
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes].count).to eq 3
          expect(item.dig(:attributes, :name)).to be_an(String)
          expect(item.dig(:attributes, :description)).to be_an(String)
          expect(item.dig(:attributes, :unit_price)).to be_an(Float)
        end
      end
    end

    context('Sad Path') do
      it 'returns array of data if no items found' do
        get api_v1_items_path
        expect(response.successful?).to eq true

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items).to be_an(Hash)
        expect(items[:data].empty?).to be true
      end
    end
  end
end
