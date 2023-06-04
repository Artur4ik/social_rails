# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        get :profile
      end
      resources :posts do
        resources :comments
      end
      get 'feed', to: 'posts#feed'
      resources :likes

      post :sign_in, action: :create, controller: 'sessions'
    end
  end
end
