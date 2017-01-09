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

  post '/prepare_stance', to: 'acts#prepare_stance'
  post '/create_stance', to: 'acts#create_stance'
  delete '/destroy_stance', to: 'acts#destroy_stance'

	post '/prepare_dot', to: 'acts#prepare_dot'
 	post '/create_dot', to: 'acts#create_dot'
 	delete '/destroy_dot', to: 'acts#destroy_dot'

  post '/prepare_subdot', to: 'acts#prepare_subdot'
  post '/create_subdot', to: 'acts#create_subdot'
  delete '/destroy_subdot', to: 'acts#destroy_subdot'

  get :search, to: 'search#index'
  get :perform_search, to: 'search#perform'

  root to: "home#index"
end
