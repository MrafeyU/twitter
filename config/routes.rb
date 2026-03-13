Rails.application.routes.draw do
   devise_for :users, controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }
  resources :posts do
    member do
      delete :remove_attachment
    end
    resources :comments 
  end

  root "pages#home"
end
