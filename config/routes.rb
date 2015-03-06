ARII::Application.routes.draw do

  get 'dashboard/index'

  get 'dashboard/show'

  get 'dashboard/update'

  get 'library/index'

  get 'library/inputs'

  get 'library/outputs'

  get 'library/integrations'

  get 'library/show'

  get 'library/get'

  resources :feedbacks

  # Home
  root  'home#index'
  get 'home' => 'home/index'
  get "home/index"

  # About
  get "about/index"

  # Agents control
  resources :inputs, :controller =>'agents'
  resources :agents
  get "agents/partials/:identifier", to: 'agents#partials'  		# what is this?
  get "agents/import/:identifier", to: "agents#import"      		# import from JSON file
  get "agents/:id/get", to: "agents#get"            		        # load agent as JSON
  get "agents/add/:identifier", to: "agents#add"            		# add sample agent to user
  get "agents/:id/execute", to: "agents#execute"                # launch on-demand agent execution

  # Alphas control
  resources :alphas
  post "alphas/request", to: 'alphas#request'

  # Caches (internal) control
  resources :caches

  # Contact
  get "contact/index", to: 'contact#index'
  get 'contacts', to: redirect('/contact/index')

  # Dashboard

  # Delivery control
  get "delivery/get"
  post "delivery/post"
  get "delivery/go"

  # Documentation
  get "docs", to: 'docs#index'
  get 'docs/:section/:topic', to: 'docs#show'

  # Endpoints controls (previously Templates)
  get 'endpoints/*all', to: redirect('/templates/%{all}')
  post 'endpoints/*all', to: redirect('/templates/%{all}')
  get 'endpoints', to: redirect('templates')
  resources :templates
  get "templates/:id/get", to: "templates#get"            # load template as JSON
  post "templates/new"
  get "templates/start"
  get "templates/add/:identifier", to: 'templates#add'            # add template from samples to user

  # Events control
  #
  get 'events/agent/:id', to: 'events#agent'
  get 'events/integration/:id', to: 'events#integration'
  resources :events
  resources :events do
     get 'page/:page', :action => :index, :on => :collection
  end

  # Files control
  get "files/get/:filename", to: "files#get"
  get "files/delete/:filename", to: "files#delete"
  get "files/index"

  # FluxCapacitor control [API]
  post "fluxcapacitor/generate_key", to: 'flux_capacitor#generate_key'
  post "fluxcapacitor/remove_key", to: 'flux_capacitor#remove_key'
  post "fluxcapacitor/validate_key", to: 'flux_capacitor#validate_key'
  post 'fluxcapacitor/verify', to: 'flux_capacitor#verify'
  get 'fluxcapacitor/ping/:ping', to: 'flux_capacitor#ping'
  post 'fluxcapacitor/ping', to: 'flux_capacitor#ping'
  post 'fluxcapacitor/generate_client', to: 'flux_capacitor#generate_client'
  get 'fluxcapacitor/generate_client', to: 'flux_capacitor#generate_client'
  post 'fluxcapacitor/agents/:id/update_meta', to: 'flux_capacitor#agent_update_meta'

  # Helpers
  get "helper/index"

  # Integrations control
  resources :integrations
  post "integrations/:id/save", to: 'integrations#save'
  get "integrations/add/:agent/:template", to: 'integrations#add'
  get "integrations/:id/execute", to: 'integrations#execute'      # execute integration on-demand
  get "integrations/:id/pause", to: 'integrations#pause'
  get "integrations/:id/play", to: 'integrations#play'

  # Postman control
  get "postman/load/:publisher/:identifier", to: "postman#load"
  get "postman/go/:identifier", to: 'postman#go'
  post "postman/deliver/:identifier", to: "postman#deliver"
  post "postman/:key", to: "postman#action"

  # Push control
  post "push/:identifier", to: "push#checkup"

  # Seeds control
  resources :seeds

  # Templates controls
  resources :outputs, :controller =>'templates'
  resources :templates
  get "templates/:id/get", to: "templates#get"            # load template as JSON
  post "templates/new"
  get "templates/start"
  get "templates/add/:identifier", to: 'templates#add'            # add template from samples to user


  # Tester controller
  get "tester/regex", to: 'tester#regex'
  get "tester/agent/:identifier", to: 'tester#agent'
  get 'tester/dropbox', to: 'tester#dropbox'


  # Authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  devise_scope :user do get "users/sign_out" => 'devise/sessions#destroy' end
  get "sign_up", :to => "devise/registrations#new"


  # Delayed job web interface
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # general index redirects
  get 'documentation' => 'documentation/index'
  get 'contact' => 'contact/index'
  get "faq" => 'faq/index'
  get "how_to" => 'how_to/index'
  get 'reference' => 'reference/index'

  # New homepage stuff
  get "how/index"
  get "use_cases/index"
  get "features/index"

  # ariip image hack
  get '/ariip/images/*all', to: redirect('/images/%{all}.png')

end