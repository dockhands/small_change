Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :deeds do 
    resources :funds, only: [:create, :destroy]
    resources :uninteresteds, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :ratings, only: [:create, :destroy]
  end 
  resource :sessions, only: [:new, :create, :destroy]


  get("/users/:id/created", { to: "users#created_deeds", as: :created_deeds})

  get("/users/:id/funded", { to: "users#funded_deeds", as: :funded_deeds})

  get("/deeds/near_me/all", { to: "deeds#near_me", as: :near_me})

  get("/deeds/fully_funded/all", { to: "deeds#fully_funded", as: :fully_funded})

  get 'tags/:tag', to: 'deeds#index', as: "tag"

  resources :complete_fundings, only: :create

  get("/about", { to: "welcome#about", as: :about})
  root({ to: 'welcome#index' })
  
end
