# frozen_string_literal: true

class ItemSerializer < DataSerializer
  def self.format_item(items)
    data = items.map do |item|
      {
        id: item.id,
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price
        }
      }
    end
    encapsulate(data)
  end
end
