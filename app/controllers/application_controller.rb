# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::StatementInvalid, with: :render_bad_request

  def render_unprocessable_entity(exception)
    render json: catch_exception_unprocessable_entity(exception), status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: catch_exception_not_found(exception), status: :not_found
  end

  def render_bad_request(exception)
    render json: catch_exception_bad_request(exception), status: :bad_request
  end

  private

  def catch_exception_not_found(exception)
    error = { status: '404', title: Rack::Utils::HTTP_STATUS_CODES[404], detail: exception }
    error_message(error)
  end

  def catch_exception_unprocessable_entity(exception)
    errors = exception.message.split(':')[1].split(',').map(&:strip)
    error = { status: '422', title: Rack::Utils::HTTP_STATUS_CODES[422], detail: errors }
    error_message(error)
  end

  def catch_exception_bad_request(exception)
    error = { status: '400', title: Rack::Utils::HTTP_STATUS_CODES[400], detail: exception }
    error_message(error)
  end

  def error_message(error)
    { message: 'your query could not be completed', errors: [error] }
  end

  def query_params
    # Curious if there is a better way to do this that is DRY!
    return params.require(:name) if params[:name]

    return [params.require(:min_price), params.require(:max_price)] if params[:min_price] && params[:max_price]

    return params.require(:min_price) if params[:min_price]

    params.require(:max_price) if params[:max_price]
  end

  def error_handler
    if params[:name] && (params[:min_price] || params[:max_price]) || query_params.nil?
      raise ActiveRecord::StatementInvalid, 'Incorrect usage of params'; end
    if params[:min_price].to_i.negative? || params[:max_price].to_i.negative?
      raise ActiveRecord::StatementInvalid, 'Price cannot be less than zero'; end
  end
end
