Rails.application.routes.draw do
  resources :contests, shallow: true do
    member do
      get 'ranking', to: 'ranking#ranking'
    end
    resources :scores
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
