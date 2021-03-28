Rails.application.routes.draw do

  resources :partners, only: %i[index show]
end
