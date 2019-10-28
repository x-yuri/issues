Rails.application.routes.draw do
  resources :posts
  get "/" => "rails/welcome#index"
  get "/ip" => "posts#ip"
  get "/assets-test" => "posts#assets_test"
end
