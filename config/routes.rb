Rails.application.routes.draw do

  resources :wikis

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
