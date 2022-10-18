# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.format_merchant(Merchant.all)
      end
    end
  end
end
