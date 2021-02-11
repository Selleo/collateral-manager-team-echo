Rails.application.routes.draw do
  resources :collaterals do
    get :tags
    post :assign_tags
    delete :deassign_tag
  end

  resources :tags
  devise_for :users
end
