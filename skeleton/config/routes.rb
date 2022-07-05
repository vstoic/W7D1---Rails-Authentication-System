Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :session, only:[:new, :create, :destroy]
  
  
  resources :cats, except: :destroy
  #custom routes to let users approve and deny new cat rentals
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve
      post :deny
    end
  end

  root to: redirect('/cats')
end
