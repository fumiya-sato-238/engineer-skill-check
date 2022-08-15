Rails.application.routes.draw do
  get '/articles/new'
  post 'articles' => 'articles#create'
  get '/articles' => 'articles#index'

  resources :dashboard, only: :index
  root 'employees#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :employees do
    resources :profiles
  end
end
