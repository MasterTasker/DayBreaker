Rails.application.routes.draw do

  get 'dashboard/view'

  get 'tasks/new'

  get 'tasks/edit'

  root to: "root#landing"

  devise_for :users

end
