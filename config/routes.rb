Rails.application.routes.draw do
  # get 'documents/new'
  # get 'documents/create'

  resources :documents, only: [:new, :create]
  devise_for :users
  root 'pages#home'
  get 'documents/export', to: 'documents#export', as: 'export_documents'
  resources :reports, only: [:index]
  
  get 'about_me', to: 'pages#about_me'
end
