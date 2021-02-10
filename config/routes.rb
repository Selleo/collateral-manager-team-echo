Rails.application.routes.draw do
  resources :collaterals
  devise_for :users
end
