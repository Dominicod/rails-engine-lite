# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    before(:each) do
      @item_1 = create(:item, name: 'boring', unit_price: 50.00)
      @item_2 = create(:item, name: 'ringmates', unit_price: 120.50)
      @item_3 = create(:item, name: 'The Ring Store', unit_price: 10.11)
      @item_4 = create(:item, name: "Dominic's Shop", unit_price: 25.25)
      @item_5 = create(:item, name: 'Unlimited Creativity', unit_price: 101.00)
    end

    describe '.find_by_name' do
      it 'should return all items with given param name' do
        expect(Item.find_by_name('ring')).to eq [@item_3, @item_1, @item_2]
      end
    end

    describe '.find_by_min_max_price' do
      it 'should return all items within given param price' do
        expect(Item.find_by_min_max_price(50, 101)).to eq [@item_1, @item_2]
      end
    end

    describe '.find_by_min_price' do
      it 'should return all items within given param price' do
        expect(Item.find_by_min_price(50)).to eq [@item_1, @item_2, @item_5]
      end
    end

    describe '.find_by_max_price' do
      it 'should return all items within given param price' do
        expect(Item.find_by_max_price(101)).to eq [@item_1, @item_3, @item_4, @item_5]
      end
    end
  end
end
