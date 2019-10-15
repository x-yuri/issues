Rails.application.routes.draw do
  resources :posts
  get "/" => "rails/welcome#index"
end
