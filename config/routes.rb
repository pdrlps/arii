ARII::Application.routes.draw do

  # Home
  root  'home#index'
  get 'home' => 'home/index'
  get "home/index"

  # About
  get "about/index"

  # Alphas control
  resources :alphas
  post "alphas/request", to: 'alphas#request'

  # Caches (internal) control
  resources :caches

  # Colors
  get '/colors', :to => redirect('/colors.html')

  # Contact
  get "contact/index", to: 'contact#index'
  get 'contacts', to: redirect('/contact/index')

  # Dashboard
  get 'dashboard/index'
  get 'dashboard/show'
  get 'dashboard/update'

  # Delivery control
  get "delivery/get"
  post "delivery/post"
  get "delivery/go"

  # Documentation
  get "docs", to: 'docs#index'
  get 'docs/:section/:topic', to: 'docs#show'

  # Events control
  get "stream" => 'events/index'
  get 'events/input/:id', to: 'events#input'
  get 'events/integration/:id', to: 'events#integration'
  resources :events
  resources :events do
     get 'page/:page', :action => :index, :on => :collection
  end

  # Feedback
  resources :feedbacks

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

  # Inputs control
  resources :inputs, :controller =>'agents'
  resources :agents
  get "inputs/partials/:identifier", to: 'agents#partials'      # what is this?
  get "inputs/import/:identifier", to: "agents#import"          # import from JSON file
  get "inputs/:id/get", to: "agents#get"                        # load agent as JSON
  get "inputs/add/:identifier", to: "agents#add"                # add sample agent to user
  get "inputs/:id/execute", to: "agents#execute"                # launch on-demand agent execution
  get "inputs/:id/enable", to: 'agents#enable'                  # enable input
  get "inputs/:id/disable", to: 'agents#disable'                # disable input

  # Integrations control
  resources :integrations
  post "integrations/:id/save", to: 'integrations#save'
  get "integrations/add/:agent/:template", to: 'integrations#add'
  get "integrations/:id/execute", to: 'integrations#execute'      # execute integration on-demand
  get "integrations/:id/enable", to: 'integrations#enable'        # enable integration
  get "integrations/:id/disable", to: 'integrations#disable'      # disable integration

  # Library control
  get 'library/index'
  get 'library/inputs'
  get 'library/outputs'
  get 'library/integrations'
  get 'library/show'
  get 'library/get'


  # Outputs controls (previously Templates)
  resources :outputs, :controller =>'templates'
  resources :templates
  get "outputs/:id/get", to: "templates#get"                    # load template as JSON
  get "outputs/start"
  get "outputs/add/:identifier", to: 'templates#add'            # add template from samples to user
  get "outputs/:id/enable", to: 'templates#enable'                # enable output
  get "outputs/:id/disable", to: 'templates#disable'              # disable output

  # Postman control
  get "postman/load/:publisher/:identifier", to: "postman#load"
  get "postman/go/:identifier", to: 'postman#go'
  post "postman/deliver/:identifier", to: "postman#deliver"
  post "postman/:key", to: "postman#action"

  # Push control
  post "push/:identifier", to: "push#checkup"

  # Seeds control
  resources :seeds

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