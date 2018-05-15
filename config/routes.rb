Rails.application.routes.draw do
  resources :papers

  get '*path', to: 'browser#index'
end
