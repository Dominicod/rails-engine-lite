# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API | Destroy' do
  describe 'Item Destroy' do
    context('Happy Path') do
      before(:each) { @item = create(:item) }

      it 'destroys a newly created item' do
        expect { delete api_v1_item_path(@item) }.to change(Item, :count).by(-1)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(204)

        expect { Item.find(@item.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'destroys a item with dependencies and destroy the invoice if this was the only item on an invoice' do
        item = create(:invoice_item).item
        invoice_id = item.invoices[0].id

        expect { delete api_v1_item_path(item.id) }.to change(Item, :count).by(-1)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(204)

        expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect { Invoice.find(invoice_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'does not destroy the invoice if it was not the only item on the invoice' do
        item = create(:invoice_item).item
        invoice_id = item.invoices[0].id
        create_list(:invoice_item, 3, invoice_id: invoice_id)

        expect { delete api_v1_item_path(item.id) }.to change(Item, :count).by(-1)
        expect(response.successful?).to eq true
        expect(response).to have_http_status(204)

        expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect { Invoice.find(invoice_id) }.to_not raise_error
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
