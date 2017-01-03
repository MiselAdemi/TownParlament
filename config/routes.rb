Rails.application.routes.draw do
  resources :amandmen
  devise_for :users
  get "home/index"
  get "home/acts"
  get "home/show"

  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :acts, :amandments
  post '/create_head_intro', to: 'acts#create_head_intro'
  delete '/destroy_head', to:'acts#destroy_head'

  post '/prepare_regulation', to: 'acts#prepare_regulation'
  post '/create_regulation', to: 'acts#create_regulation'
  delete '/destroy_regulation', to: 'acts#destroy_regulation'

  root to: "home#index"
end
