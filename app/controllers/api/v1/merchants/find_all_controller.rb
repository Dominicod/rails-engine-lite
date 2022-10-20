# frozen_string_literal: true

module Api
  module V1
    module Items
      class FindAllController < ApplicationController
        def index
          merchants = Merchant.find_all(query_params)
          if merchants.nil? || merchants.empty?
            render json: empty_arr
          else
            render json: MerchantSerializer.new(merchants)
          end
        end

        private

        def empty_arr
          { data: [] }
        end

        def query_params
          binding.pry
          params.require(:name)
        end
      end
    end
  end
end
