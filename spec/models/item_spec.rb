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
    let!(:load_objects) do
      @item_1 = create(:item, name: 'boring', unit_price: 50.00)
      @item_2 = create(:item, name: 'ringmates', unit_price: 120.50)
      @item_3 = create(:item, name: 'The Ring Store', unit_price: 10.11)
      @item_4 = create(:item, name: "Dominic's Shop", unit_price: 25.25)
      @item_5 = create(:item, name: 'Unlimited Creativity', unit_price: 101.00)
    end

    describe '.find_all_by_name' do
      it 'should return all items with given param name' do
        expect(Item.find_all_by_name('ring')).to eq [@item_3, @item_1, @item_2]
      end
    end

    describe '.find_all_by_min_max_price' do
      it 'should return all items within given param price' do
        expect(Item.find_all_by_min_max_price([50, 101])).to eq [@item_5, @item_1]
      end
    end

    describe '.find_all_by_min_price' do
      it 'should return all items within given param price' do
        expect(Item.find_all_by_min_price(50)).to eq [@item_5, @item_1, @item_2]
      end
    end

    describe '.find_all_by_max_price' do
      it 'should return all items within given param price' do
        expect(Item.find_all_by_max_price(101)).to eq [@item_4, @item_3, @item_5, @item_1]
      end
    end

    describe '.find_by_name' do
      it 'should return one item within given name param' do
        expect(Item.find_by_name('ring')).to eq @item_3
      end
    end

    describe '.find_by_min_max_price' do
      it 'should return one item within given param price' do
        expect(Item.find_by_min_max_price([10, 30])).to eq @item_4
      end
    end

    describe '.find_by_min_price' do
      it 'should return one item within given param price' do
        expect(Item.find_by_min_price(60)).to eq @item_5
      end
    end

    describe '.find_by_max_price' do
      it 'should return one item within given param price' do
        expect(Item.find_by_max_price(101)).to eq @item_4
      end
    end
  end

  describe 'instance methods' do
    describe '.destroy_associations' do
      it 'removes all invoices if the invoice items count is == 1' do
        item = create(:invoice_item).item
        item.invoices[0].id

        # Destroying a Item causes a before_destroy callback, calling .destroy_associations
        Item.destroy(item.id)

        expect(Invoice.all.count).to eq 0
      end

      it 'does not remove all invoices if invoice has more than one item' do
        item = create(:invoice_item).item
        invoice_id = item.invoices[0].id
        create(:invoice_item, invoice_id: invoice_id)

        # Destroying a Item causes a before_destroy callback, calling .destroy_associations
        Item.destroy(item.id)

        expect(Invoice.all.count).to eq 1
      end
    end
  end
end
