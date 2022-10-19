# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '.find_by_name' do
      it 'should return a single merchant with given param name' do
        create_list(:merchant, 10)
        merchant = create(:merchant, name: 'boring')
        create(:merchant, name: 'thering')
        create(:merchant, name: 'ringbewildin')

        expect(Merchant.find_by_name('ring')).to eq merchant
      end
    end
  end
end
