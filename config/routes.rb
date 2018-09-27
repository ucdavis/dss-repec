Rails.application.routes.draw do
  resources :papers
  resources :authors

  get '/papers/:id/download', as: :paper_rdf , action: :show_rdf, controller: :browser
  get '*path', to: 'browser#index', as: :pathway
end
