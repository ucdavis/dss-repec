Rails.application.routes.draw do
  resources :users do
    collection do
      delete 'destroy_multiple'
    end
  end

  resources :papers do
    collection do
      delete 'destroy_multiple'
    end
  end

  resources :authors do
    collection do
      delete 'destroy_multiple'
    end
  end

  get 'repec/cda/wpaper/:id.redif', as: :paper_redif , action: :show_redif, controller: :browser
  get '/:path', to: 'browser#index', as: :pathway, constraints: { path: /repec[\/a-zA-Z]*/i }

  root to: 'browser#index'
end
