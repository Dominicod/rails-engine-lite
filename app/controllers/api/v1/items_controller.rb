# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      def create
        render json: ItemSerializer.new(Item.create!(item_params)), status: 201
      end

      def destroy
        item = Item.find(params[:id])
        invoices = item.invoices
        invoices.each { |invoice| invoice.destroy if invoice.items.count == 1 }
        item.destroy
      end

      def update
        Merchant.find(params.dig(:item, :merchant_id)) if params.dig(:item, :merchant_id)
        render json: ItemSerializer.new(Item.update(params[:id], item_params))
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
