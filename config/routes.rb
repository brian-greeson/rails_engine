Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items do
        get "/merchants", to: "item_merchants#index"
      end
      
      resources :merchants do
        get "/items", to: "merchant_items#index"
      end
      
    end
  end
end
