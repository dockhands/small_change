Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :deeds do 
    resources :funds, only: [:create, :destroy]
  end 
  resource :sessions, only: [:new, :create, :destroy]


  get("/users/:id/created", { to: "users#created_deeds", as: :created_deeds})

  get("/users/:id/funded", { to: "users#funded_deeds", as: :funded_deeds})

  root({ to: 'welcome#index' })
end
