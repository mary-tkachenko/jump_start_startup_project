Rails.application.routes.draw do
  
  resources :aplications
  # resources :reviews
  # project/id/new
  # proj
  resources :projects do 
    resources :reviews, except: [:show, :index]
    resources :employers

  end

  root 'welcome#index'

  resources :messages, only: [:index, :create] do
    get '/chat/:user_id', action: :chat, as: 'chat', on: :collection
  end


  devise_for :developers, path: 'developers', :controllers => { registrations: 'developers/registrations' }
  devise_for :employers, path: 'employers', :controllers => { registrations: 'employers/registrations' }
  get '/developers', to: 'developers#index'
  get '/developers/:id', to: 'developers#show', as: 'developer'
  

  as :employers do
    get '/employers', to: 'employers#index'
    get '/employers/:id', to: 'employers#show', as: 'employer'
    get '/employers/my/projects', to: 'employers#index_projects'
  end

  as :developers do
    get '/developers/my/projects', to: 'developers#index_projects'
  end
  
  get '/dashboard', to: 'welcome#dashboard'
  get '/login', to: 'welcome#login'
end
