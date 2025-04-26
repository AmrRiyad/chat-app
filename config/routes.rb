require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  resources :applications, param: :token, only: [ :index, :create, :show ] do
    resources :chats, param: :number, only: [ :index, :create, :show ] do
      resources :messages, param: :number, only: [ :index, :create, :show ]
    end
  end
end
