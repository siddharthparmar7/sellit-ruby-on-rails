Rails.application.routes.draw do
  resources :items do
    collection do
      get :search
      # put :action
      get :filter
      # delete :action
    end
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
