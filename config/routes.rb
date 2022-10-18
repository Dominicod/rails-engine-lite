# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        resources :items, module: :merchant, only: %i[index]
      end
      resources :items, only: %i[index show] do
        resources :merchant, module: :item, only: %i[index]
      end
    end
  end
end
