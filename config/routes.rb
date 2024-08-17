Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users

  resources :documents, only: [:new, :create] do
    collection do
      get 'export', to: 'documents#export', as: 'export'
    end
  end

  resources :reports, only: [:index] do
    collection do
      delete 'reset_database', to: 'reports#reset_database'
    end
  end

  get 'about_me', to: 'pages#about_me'
end