Rails.application.routes.draw do
  constraints Tyr.config.api_constraints do
    scope module: 'api' do
      root to: 'base#index', as: :api_root
      get '/error', to: 'base#error'
      resources :banks, only: [:index] do
        member do
          get :branches
        end
      end
    end
  end

  mount Tyr::Engine => '/'

  instance_exec(&Tyr.config.proc_route_404)
end
