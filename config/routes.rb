Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    api version: 1, module: 'v1' do
      resources :recipes
      resources :releases
    end
  end
end
