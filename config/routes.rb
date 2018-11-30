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

  # Some helpful redirects
  get '/login', to: redirect('/papers')
  get '/admin', to: redirect('/papers')

  # FileController to avoid ActiveStorage redirects (credit: https://github.com/rails/rails/issues/31419#issuecomment-399118697)
  get '/files/:key/*filename', to: 'files#show', as: :rails_public_blob
  direct :public_blob do |blob, options|
    route_for(:rails_public_blob, blob.key, blob.filename, options)
  end
  resource :files, only: :show

  root to: 'browser#index'
end
