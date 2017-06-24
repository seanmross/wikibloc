Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :charges, only: [:new, :create]

  resources :wikis

  get 'welcome/index'

  get 'welcome/about' => 'welcome#index'

  root 'welcome#index'
end
