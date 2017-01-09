Rails.application.routes.draw do
  resources :amandmen
  devise_for :users
  get "home/index"
  get "home/meeting"

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

  post '/prepare_subject', to: 'acts#prepare_subject'
  post '/create_subject', to: 'acts#create_subject'
  delete '/destroy_subject', to: 'acts#destroy_subject'

  post '/prepare_clause', to: 'acts#prepare_clause'
  post '/create_clause', to: 'acts#create_clause'
  delete '/destroy_clause', to: 'acts#destroy_clause'

  get :search, to: 'search#index'

  root to: "home#index"
end
