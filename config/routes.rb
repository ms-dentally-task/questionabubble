Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "questions#new"

  resources :questions, only: [:new, :create, :show, :index]
  resources :question_responses, only: [:create, :show]
end
