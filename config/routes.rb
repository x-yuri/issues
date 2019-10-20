Rails.application.routes.draw do
  resources :posts
  get "/" => "rails/welcome#index"
  get "/ip" => "posts#ip"
end
