Rails.application.routes.draw do
  namespace :admin do resources :users end
  get 'home/index'

  devise_for :users
  get "home/index"

  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do

    resources :users

  end

  root to: "home#index"
end
