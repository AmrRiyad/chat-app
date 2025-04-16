# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :applications, param: :token, only: [ :index, :create ] do
    resources :chats, only: [ :index, :new, :create ]
  end
end
