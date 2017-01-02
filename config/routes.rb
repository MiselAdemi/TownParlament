Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  get "home/acts"
  get "home/show"

  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :acts, :amandments

  root to: "home#index"
end
