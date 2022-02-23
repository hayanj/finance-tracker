Rails.application.routes.draw do
  devise_for :users
#To fix the get route error
  devise_scope :user do
     get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # devise_for :users do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
