Rails.application.routes.draw do

  root to: "home#index"

  get 'users/new'

end
