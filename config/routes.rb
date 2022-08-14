Rails.application.routes.draw do
  get 'articles/new'
  resources :dashboard, only: :index
  root 'employees#index'
  get '/articles' => 'articles#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :employees do
    resources :profiles
  end
end
