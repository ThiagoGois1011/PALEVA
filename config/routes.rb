Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: 'home#index'

  resources :establishments, only: [:new, :create, :show] do
    get 'search', on: :collection
    resources :opening_hours, only: [:new, :create]
    resources :dishes, only: [:index, :create, :new, :edit, :destroy, :update, :show] do
      post 'status', on: :member
      resources :portions, only: [:create, :new, :edit, :update] do
        resources :historicals, only: [:index]
      end
    end
    resources :beverages, only: [:index, :create, :new, :edit, :destroy, :update, :show] do
      post 'status', on: :member
    end
  end
  
end
