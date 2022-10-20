# frozen_string_literal: true

module Api
  module V1
    module Items
      class FindController < ApplicationController
        def index
          return if error_handler

          item = query_decision
          if item.nil?
            render json: empty_arr
          else
            render json: ItemSerializer.new(item)
          end
        end

        private

        def empty_arr
          { data: [] }
        end

        def query_decision
          # Curious if there is a better way to do this that is DRY!
          return Item.find_by_name(query_params) if params[:name]

          return Item.find_by_min_max_price(query_params) if params[:min_price] && params[:max_price]

          return Item.find_by_max_price(query_params) if params[:max_price]

          Item.find_by_min_price(query_params) if params[:min_price]
        end
      end
    end
  end
end
