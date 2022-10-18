# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_unprocessable_entity(exception)
    render json: catch_exception_unprocessable_entity(exception), status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: catch_exception_not_found(exception), status: :not_found
  end

  private

  def catch_exception_not_found(exception)
    error = { status: '404', title: Rack::Utils::HTTP_STATUS_CODES[404], detail: exception }
    { message: 'your query could not be completed', error: [error] }
  end

  def catch_exception_unprocessable_entity(exception)
    error = { status: '422', title: Rack::Utils::HTTP_STATUS_CODES[422], detail: exception }
    { message: 'your query could not be completed', error: [error] }
  end
end
