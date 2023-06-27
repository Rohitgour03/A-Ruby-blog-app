Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments
  end
  root to: "articles#index"

  resources :categories
  resources :tags

  # get "/categories", to: "categories#index"
  # get "/categories/:id", to: "categories#show"

end
