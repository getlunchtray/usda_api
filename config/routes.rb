Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    api version: 1, module: 'v1' do
      resources :sessions, only: [:create]
      resources :recipes
    end
  end
end
