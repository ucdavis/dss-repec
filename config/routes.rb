Rails.application.routes.draw do
  resources :papers
  resources :authors do
    collection do
      delete 'destroy_multiple'
    end
  end

  get '/papers/:id/download', as: :paper_rdf , action: :show_rdf, controller: :browser
  get '*path', to: 'browser#index', as: :pathway

  #get '/:path', to: 'browser#index', as: :pathway, constraints: { path: /repec[\/a-zA-Z]*/i }
end
