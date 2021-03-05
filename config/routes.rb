Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/launch", to: "launches#new"
  root to: "pages#index"
end
