Rails.application.routes.draw do
  resources :collaterals do
    get :tags
    post :assign_tags
    get :search_collaterals, :on => :collection, as: :search
    delete :deassign_tag
  end

  resources :tags
  devise_for :users
end
