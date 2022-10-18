# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Destroy' do
  describe 'Item Destroy' do
    context('Happy Path') do
      before(:each) { @item = create(:item) }

      it 'destroys an item' do
        expect { delete api_v1_items_path(@item) }.to change(Item, :count).by(-1)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(204)

        expect { Item.find(@item.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context('Edge Case') do
      xit 'returns error message if :id is not found' do
        get api_v1_item_path(40)

        expect(response.successful?).to eq false

        item_response = JSON.parse(response.body, symbolize_names: true)
        # expect(response).to have_http_status()
      end
    end
  end
end
