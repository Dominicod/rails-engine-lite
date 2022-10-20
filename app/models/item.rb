# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :delete_all
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def self.find_by_name(params)
    where('name ILIKE ?', "%#{params}%").order(:name)
  end

  def self.find_by_min_price(params)
    where('unit_price >= ?', params).order(:name)
  end

  def self.find_by_max_price(params)
    where('unit_price <= ?', params).order(:name)
  end

  def self.find_by_min_max_price(params)
    where('unit_price >= ? AND unit_price <= ?', params[0], params[1]).order(:name)
  end
end
