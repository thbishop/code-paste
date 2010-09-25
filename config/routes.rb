CodePaste::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  resources :pastes
  
  root :to => 'pastes#new'
  
  match '/login' => 'static#legal', :as => :purchase
end