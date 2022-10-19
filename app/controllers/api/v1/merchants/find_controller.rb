# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class FindController < ApplicationController
        def index
          render json: MerchantSerializer.new(Merchant.find_by_name(query_params))
        end

        private

        def query_params
          params.require(:query)
        end
      end
    end
  end
end
