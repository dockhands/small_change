Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :deeds do 
    resources :funds, only: [:create, :destroy]
  end 
  resource :sessions, only: [:new, :create, :destroy]


  get("/users/:id/created", { to: "users#created_deeds", as: :created_deeds})

  get("/users/:id/funded", { to: "users#funded_deeds", as: :funded_deeds})

  get("/deeds/near_me/all", { to: "deeds#near_me", as: :near_me})

  get 'tags/:tag', to: 'deeds#index', as: "tag"

  resources :complete_fundings, only: :create

  root({ to: 'welcome#index' })
end
