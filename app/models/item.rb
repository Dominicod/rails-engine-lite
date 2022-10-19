# frozen_string_literal: true

class Item < ApplicationRecord
  before_destroy :destroy_associations

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def self.find_by_name(params)
    where('name ILIKE ?', "%#{params}%").order(:name)
  end

  private

  def destroy_associations
    invoices.each { |invoice| invoice.destroy if invoice.items.count == 1 }
  end
end
