Rails.application.routes.draw do

  root to: "root#landing"

  devise_for :users

end
