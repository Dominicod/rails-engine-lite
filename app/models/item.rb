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

  scope :find_all_by_name, ->(params) { where('name ILIKE ?', "%#{params}%").order(:name) }
  scope :find_all_by_min_price, ->(params) { where('unit_price >= ?', params).order(:name) }
  scope :find_all_by_max_price, ->(params) { where('unit_price <= ?', params).order(:name) }
  scope :find_all_by_min_max_price, lambda { |params|
                                      where('unit_price >= ? AND unit_price <= ?', params[0], params[1]).order(:name)
                                    }

  def self.find_by_name(params)
    find_all_by_name(params).first
  end

  def self.find_by_min_price(params)
    find_all_by_min_price(params).first
  end

  def self.find_by_max_price(params)
    find_all_by_max_price(params).first
  end

  def self.find_by_min_max_price(params)
    find_all_by_min_max_price(params).first
  end

  private

  def destroy_associations
    invoices.each do |invoice|
      invoice.destroy if invoice.items.count == 1 && invoice.items[0].id == id
    end
  end
end
