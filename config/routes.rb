Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: 'home#index'
  get 'registration', to:'employees#registration', as: 'employees_registration'
  patch 'complete_registration', to:'employees#complete_registration'

  resource :establishment, only: [:new, :create, :show] do
    get 'search', on: :collection

    resources :opening_hours, only: [:new, :create]

    resources :dishes, only: [:index, :create, :new, :edit, :destroy, :update, :show] do
      post 'status', on: :member
      get 'filter', on: :collection
      resources :portions, only: [:create, :new, :edit, :update] do
        resources :historicals, only: [:index]
      end
    end

    resources :markers, only: [:create, :new]

    resources :beverages, only: [:index, :create, :new, :edit, :destroy, :update, :show] do
      post 'status', on: :member
      resources :portions, only: [:create, :new, :edit, :update] do
        resources :historicals, only: [:index]
      end
    end

    resources :menus, only: [:index, :create, :new, :show] do
      resources :order_items, only: [:new, :create]
    end
    get 'continue_order', to: 'orders#continue_order'
    patch 'change_current_order', to: 'orders#change_current_order'
    resources :orders, only: [:new, :create] do
      get 'confirm_order', on: :collection
      patch 'finalize', on: :collection
    end
    

    resources :employees, only: [:index, :new, :create]
  end

  namespace :api do
    namespace :v1 do
      resources :establishments, param: :code, only: [] do
        resources :orders, only: [:index]
      end
    end
  end
  
end
