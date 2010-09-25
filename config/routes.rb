CodePaste::Application.routes.draw do
  resources :pastes
  
  root :to => 'pastes#new'
  
  match '/legal' => 'static#legal', :as => :purchase
end