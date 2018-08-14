Rails.application.routes.draw do
  get 'authors/new'
  #get 'browser/index'

  resources :papers

  #root 'browser#index'

  get '*path', to: 'browser#index', as: :pathway

   # get '/browser/repec', to: 'browser#repec', as: "repec"
end
