Rails.application.routes.draw do
  # devise_for :users
  root to: "users#index"
  get '/user' => "users#index" 
  get '/tutors/new' => "tutors#new"
  post 'tutors' => "tutors#create"
  get '/show/:id' => "tutors#show"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

