Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
     get '/',to: 'welcome#home'
   resources :users

   resources :locations


    resources :reviews
    #nested routes
       resources :users do
       resource :locations
     end
     resources :locations do
       resources :reviews
     end
end
