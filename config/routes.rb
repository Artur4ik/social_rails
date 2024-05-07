# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, param: :name, only: %i[show create] do
        post :follow, controller: 'relationships'
        post :unfollow, controller: 'relationships'
      end
      resources :posts, except: %i[edit new] do
        resource :like, only: %i[create destroy], controller: 'posts/likes'
        resources :comments, except: %i[edit new] do
          resource :like, only: %i[create destroy], controller: 'comments/likes'
        end
        get :feed, on: :collection
      end
      resource :profile, only: %i[show update destroy]

      post :sign_in, action: :create, controller: 'sessions'
    end
  end
end
