# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: catch_exception(exception), status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: catch_exception(exception), status: :not_found
  end

  private

  def catch_exception(exception)
    binding.pry
  end
end
