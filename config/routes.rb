Rails.application.routes.draw do

  get 'dashboard/view'

  devise_for :users, {
    path_names: {
      sign_in: 'login',
      sign_out: 'logout'
    },
    controllers: {
      omniauth_callbacks: "omniauth_callbacks"
    }
  }

  unauthenticated :user do
    root to: 'root#landing'
  end

  authenticate :user do
    get    '/', to: redirect('tasks')

    scope  '/tasks' do
      get    '/',    to: 'tasks#index',  as: :tasks
      post   '/',    to: 'tasks#create', as: :create_task
      get    '/new', to: 'tasks#new',    as: :new_task
      scope  '/:id', constraints: UuidConstraint.new do
        patch  '/',       to: 'tasks#update',              as: :update_task
        delete '/',       to: 'tasks#destroy',             as: :destroy_task
        get    '/edit',   to: 'tasks#edit',                as: :edit_task
      end
    end

  end

end
