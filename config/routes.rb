Rails.application.routes.draw do
  resources :papers
  resources :authors

  get '*path', to: 'browser#index', as: :pathway
end
