# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class ItemsController < ApplicationController
        def index
          binding.pry
          render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
        end
      end
    end
  end
end
