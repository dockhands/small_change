Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :deeds
  resource :sessions, only: [:new, :create, :destroy]

  root({ to: 'welcome#index' })
end
