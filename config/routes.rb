# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :comments
      resources :likes
      post :sign_in, action: :create, controller: 'sessions'
    end
  end
end
