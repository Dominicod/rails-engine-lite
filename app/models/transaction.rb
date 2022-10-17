# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :invoice_id, presence: true
  validates :credit_card_number, presence: true
  validates :result, presence: true
  enum result: %i[success failed]
end
