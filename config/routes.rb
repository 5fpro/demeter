Rails.application.routes.draw do
  constraints Tyr.config.api_constraints do
    scope module: 'api' do
      root to: 'base#index', as: :api_root
      get '/error', to: 'base#error'
      resources :banks, only: [:index] do
        collection do
          get :branch_list
        end
      end
    end
  end

  mount Tyr::Engine => '/'

  instance_exec(&Tyr.config.proc_route_404)
end
