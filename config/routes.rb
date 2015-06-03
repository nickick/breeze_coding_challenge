Rails.application.routes.draw do
  resources :users do
    resources :items do
    end
  end
end
