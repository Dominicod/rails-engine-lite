# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.format_merchant(Merchant.all)
      end

      def show
        render json: MerchantSerializer.format_merchant([Merchant.find(params[:id])])
      end
    end
  end
end
