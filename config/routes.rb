# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/find#index'
      get '/items/find', to: 'items/find#index'

      resources :merchants, only: %i[index show] do
        resources :items, module: :merchants, only: %i[index]
      end
      resources :items do
        resources :merchant, module: :items, only: %i[index]
      end
    end
  end
end
