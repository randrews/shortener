Rails.application.routes.draw do
  root 'links#new'

  post '/' => 'links#create'
  get '/:key' => 'links#show'
end
