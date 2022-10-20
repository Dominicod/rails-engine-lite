# frozen_string_literal: true

module Api
  module V1
    module Items
      class FindController < ApplicationController
        def index
          merchant = Merchant.find_by_name(query_params)
          if merchant.nil?
            render json: empty_hash
          else
            render json: MerchantSerializer.new(merchant)
          end
        end

        private

        def empty_hash
          { data: {} }
        end

        def query_params
          params.require(:name)
        end
      end
    end
  end
end
