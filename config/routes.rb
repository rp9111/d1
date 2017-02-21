Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'signins#create'
  post '/auth/:provider/callback', to: 'signins#create'
  get '/auth/failure', to: 'signins#create'
  get '/delete_identity/:provider', to: 'signins#remove', as: 'delete_identity'
  get 'p/:promo', to: 'promos#show', as: :promo

  get '/admin', to: 'admin/dashboard#show'
  namespace :admin do
    resources :areas do
      put 'reorder', on: :collection
    end
    resources :pages do
      put 'reorder', on: :collection
    end
    resources :comments
    resources :groups
    resources :users
    resources :skus
    resources :promos
    resources :themes
    resource :dashboard, only: [:show]
  end

  post 'upload', to: 'uploads#create'

  resources :areas, only: [:show]
  resource :user, only: [:new, :create, :edit, :update, :destroy] do
    get :deactivate
  end
  resources :comments
  resources :subscriptions

  get :signup, to: 'users#new', as: 'signup'
  resource :signin, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  get :signin, to:  'signins#new'
  get :request_reset, to:  'signins#edit', as: :request_reset
  get :signout, to:  'signins#destroy'
  put :reset_password, to: 'signins#update', as: :reset_password
  get 'confirm/:token', to: 'signins#confirm', as: :confirm
  get 'profile', to: 'users#edit', as: :profile
  get 'sitemap.xml' => 'sitemap#index', as: 'sitemap', defaults: { format: 'xml' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  get ':permalink', to: 'areas#show'
  root to: 'areas#show'
end
