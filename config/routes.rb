Rails.application.routes.draw do
   devise_for :users, controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }
  resources :posts do
    collection do
      delete :remove_attachment
      get :search
    end
    resources :comments 
  end

  root "pages#home"
end
