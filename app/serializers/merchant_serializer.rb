# frozen_string_literal: true

class MerchantSerializer < DataSerializer
  def self.format_merchant(merchants)
    data = merchants.map do |merchant|
      {
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    end
    encapsulate(data)
  end
end
