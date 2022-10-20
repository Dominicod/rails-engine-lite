# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.find_by_name(params)
    where('name ILIKE ?', "%#{params}%").order(:name).first
  end

  scope :find_all_by_name, ->(params) { where('name ILIKE ?', "%#{params}%").order(:name) }
end
