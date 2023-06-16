Rails.application.routes.draw do
  root 'urls#index'
  post '/', to: 'urls#create'
  get '/:slug', to: 'urls#show'
  get '/:slug/info', to: 'urls#info', as: 'url_info'
end
