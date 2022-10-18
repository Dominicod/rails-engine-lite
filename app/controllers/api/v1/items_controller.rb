# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.format_item(Item.all)
      end

      def show
        render json: ItemSerializer.format_item([Item.find(params[:id])])
      end
    end
  end
end
