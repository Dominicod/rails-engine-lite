# frozen_string_literal: true

module Api
  module V1
    module Items
      class FindAllController < ApplicationController
        def index
          return if error_handler

          items = query_decision
          if items.nil? || items.empty?
            render json: empty_arr
          else
            render json: ItemSerializer.new(items)
          end
        end

        private

        def empty_arr
          { data: [] }
        end

        def query_params
          # Curious if there is a better way to do this that is DRY!
          return params.require(:name) if params[:name]

          return [params.require(:min_price), params.require(:max_price)] if params[:min_price] && params[:max_price]

          return params.require(:min_price) if params[:min_price]

          params.require(:max_price) if params[:max_price]
        end

        def query_decision
          # Curious if there is a better way to do this that is DRY!
          return Item.find_by_name(query_params) if params[:name]

          return Item.find_by_min_max_price(query_params) if params[:min_price] && params[:max_price]

          return Item.find_by_max_price(query_params) if params[:max_price]

          Item.find_by_min_price(query_params) if params[:min_price]
        end

        def error_handler
          if params[:name] && (params[:min_price] || params[:max_price]) || query_params.nil?
            raise ActiveRecord::StatementInvalid, 'Incorrect usage of params'; end
          if params[:min_price].to_i.negative? || params[:max_price].to_i.negative?
            raise ActiveRecord::StatementInvalid, 'Price cannot be less than zero'; end
        end
      end
    end
  end
end
