Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, %w[OK]] }
  get "/healthcheck-f", to: proc {
    GovukError.notify('Sentry works')
    [200, {}, ["Sentry notified"]]
  }
  get '/dev' => 'development#index'

  get '/metrics/*base_path', to: 'metrics#show'
  mount GovukPublishingComponents::Engine, at: "/component-guide"
end
