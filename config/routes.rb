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

  # Static file rewrites. Must come before other 'repec/' paths
  get 'repec/cda/cdaarch.rdf', to: static('cdaarch.rdf')
  get 'repec/cda/cdaseri.rdf', to: static('cdaseri.rdf')

  get 'repec/cda/wpaper/:id.rdf', as: :paper_rdf , action: :show_rdf, controller: :browser
  get '/:path', to: 'browser#index', as: :pathway, constraints: { path: /repec[\/a-zA-Z]*/i }

  root to: 'browser#index'
end
