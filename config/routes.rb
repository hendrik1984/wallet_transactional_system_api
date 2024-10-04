Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, path: 'wallet/users'
      resources :teams, path: 'wallet/teams'
      resources :stocks, path: 'wallet/stocks'
      
      resources :transactions
      
      resources :wallets do
        member do
          post 'deposit'
          post 'withdraw'
          post 'transfer'
        end
      end

      resources :transactions
    end
  end
end
