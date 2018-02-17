Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  scope defaults: { format: :html} do
    resources :products do
      member do
        put :subscribe
        delete :unsubscribe
      end
    end

    resources :home, only: [] do
      collection do
        get 'index/(:tag)', action: :index, as: :all
        get 'mine/(:tag)', action: :mine, as: :mine
      end
    end
  end

  scope defaults: { format: :json } do
    namespace :api do
      resources :products, only: %i[index show]
    end
  end

end
