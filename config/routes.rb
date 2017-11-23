Rails.application.routes.draw do
  
  # match ':controller(/:action(/:week))', :via => :get
  get '/program/index', to: 'program#index'
  get '/program/subjects/:week', to: 'program#subjects'
  get "/program/show/:subject", to: "program#show", constraints: { subject: /.*/ }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'program#index'
end
