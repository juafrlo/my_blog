ActionController::Routing::Routes.draw do |map|
  map.sitemap '/sitemap.xml', :controller => 'sitemap'
  
  map.resources :contacts, :only => [:index, :create], :as => 'contacto'

  map.resources :comments, :only => [:create, :destroy]

  map.resources :posts, :collection => {:search => :get}
  map.resources :tags, :only => [:show]
  
  map.home '', :controller => 'posts', :action => 'index'
  map.resources :sessions
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
