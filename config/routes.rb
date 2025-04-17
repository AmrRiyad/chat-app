# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :applications, param: :token, only: [ :index, :create, :show ] do
    resources :chats, param: :number, only: [ :index, :create, :show ] do
      resources :messages, param: :number, only: [ :index, :create, :show ]
    end
  end
end
