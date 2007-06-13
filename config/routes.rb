ActionController::Routing::Routes.draw do |map|

  map.resources :home, :path_prefix => "/bus_admin", :controller => "bus_admin/home"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/indicators"

  map.resources :targets, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/targets"

  map.resources :targets, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/targets"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/", :controller => "/indicators"

  map.resources :targets, :active_scaffold => true, :path_prefix => "/", :controller => "/targets"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/", :controller => "/indicators"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/", :controller => "/indicators"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/", :controller => "/indicators"

  map.resources :indicators, :active_scaffold => true, :path_prefix => "/", :controller => "/indicators"

  map.resources :targets, :active_scaffold => true, :path_prefix => "/", :controller => "/targets"

  map.resources :millennium_development_goals, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/millennium_development_goals"

  map.resources :sectors, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/sectors"

  map.resources :urban_centres, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/urban_centres"

  map.resources :village_groups, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/village_groups"

  map.resources :cities, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/cities"

  map.resources :village_groups, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/village_groups"
  map.resources :cities, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/cities"
  map.resources :countries, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/countries"
  map.resources :villages, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/villages"
  map.resources :regions, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/regions"
  map.resources :countries, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/countries"
  map.resources :projects, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => 'bus_admin/projects' do |project|
    project.resources :project_histories, :active_scaffold => true, :path_prefix => '/bus_admin', :controller => 'bus_admin/project_histories'
  end
  map.resources :continents, :controller => 'bus_admin/continents', :active_scaffold => true, :path_prefix => '/bus_admin'
  map.resources :contacts, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => 'bus_admin/contacts'

  map.resources :partner_statuses, :active_scaffold => true, :controller => "bus_admin/partner_statuses", :path_prefix => "/bus_admin"
  map.resources :partner_types, :active_scaffold => true, :controller => "bus_admin/partner_types", :path_prefix => "/bus_admin"
  map.resources :partners, :active_scaffold => true,  :path_prefix => '/bus_admin', :controller => 'bus_admin/partners' do |partner|
    partner.resources :partner_histories, :active_scaffold => true, :path_prefix => '/bus_admin', :controller => 'bus_admin/partner_histories' 
  end
  # hack around the active_scaffold's non-restful support of nesting
  map.resources :partner_histories, :active_scaffold => true, :path_prefix => '/bus_admin', :controller => 'bus_admin/partner_histories' 
  map.resources :project_histories, :active_scaffold => true, :path_prefix => '/bus_admin', :controller => 'bus_admin/project_histories' 
  map.resources :region_types, :controller => "bus_admin/region_types",
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Gather normal 'lookup' resources together.  Standard RESTful resources, no nesting
  map.resources :project_statuses, :controller => "bus_admin/project_statuses",
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  map.resources :milestone_statuses, :controller => "bus_admin/milestone_statuses", 
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  map.resources :task_statuses, :controller => "bus_admin/task_statuses", 
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  map.resources :task_categories, :controller => "bus_admin/task_categories",
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  map.resources :milestone_categories, :controller => "bus_admin/milestone_categories",
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true
  map.resources :project_categories, :active_scaffold => true, :controller => "bus_admin/project_categories", :path_prefix => "/bus_admin" 
  map.resources :partner_types
  map.resources :measure_categories, :controller => "bus_admin/measure_categories",
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin", :active_scaffold => true

  
  #map.resources :partner_histories
    
  map.resources :programs, :active_scaffold => true, :controller => "bus_admin/programs", :path_prefix => "/bus_admin"
  map.resources :projects#, :active_scaffold => true #, :path_prefix => "/programs/:program_id"
  map.resources :project_histories, :path_prefix => "/projects/:project_id"
  map.resources :milestones, :path_prefix => "/projects/:project_id"
  map.resources :milestone_histories, :path_prefix => "/milestones/:milestone_id"
  #map.resources :tasks, :path_prefix => "/milestones/:milestone_id"
  map.resources :tasks, :controller => "bus_admin/tasks", :active_scaffold => true,
    :name_prefix => 'bus_admin_', :path_prefix => "/bus_admin/milestones/:milestone_id"
  map.resources :task_histories, :path_prefix => "/tasks/:task_id"
  map.resources :measures
  
  #map.resources :regions, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/regions"  #, :path_prefix => "/countries/:country_id"
 
  map.resources :village_groups # , :path_prefix => "/regions/:region_id"
  map.resources :villages #, :path_prefix => "/village_groups/:village_group_id"
  
  # front-end resources - non-admin
  map.resource :dt do |dt|
    dt.resources :projects, :name_prefix => 'dt_', :controller=> 'dt/projects'
    #dt.resources :accounts, :name_prefix => 'dt_', :controller=> 'dt/accounts'
    #dt.resources :groups, :name_prefix => 'dt_', :controller=> 'dt/groups'
  end
  
  #easier routes for restful_authentication
  
  map.signup '/bus_admin/signup', :controller => 'bus_admin/bus_account', :action => 'signup'
  map.login '/bus_admin/login', :controller => 'bus_admin/bus_account', :action => 'login'
  map.logout '/bus_admin/logout', :controller => 'bus_admin/bus_account', :action => 'logout'
  map.index '/bus_admin/index', :controller => 'bus_admin/bus_account', :action => 'index'
  map.resources :bus_account, :active_scaffold => true, :path_prefix => "/bus_admin", :controller => "bus_admin/bus_account"
  map.change_password '/bus_admin/change_password', :controller => 'bus_admin/bus_account', :action =>'change_password'
  map.show_encryption '/bus_admin/bus_account/show_encryption', :controller =>'bus_admin/bus_account',:action =>'show_encryption'
  map.change_password_now '/bus_admin/bus_account/change_password_now', :controller => 'bus_admin/bus_account', :action =>'change_password_now'
  #map.display_pending '/bus_admin/display_pending', :controller => 'bus_admin/partners', :action =>'display_pending'
  map.home '/bus_admin/index', :controller => 'bus_admin/home', :action=> 'index'
 
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  
  # Install the default route as the lowest priority.
  # HPD these should not be used / exist when using 'full' RESTful structure
  #map.connect ':controller/:action/:id.:format'
  #map.connect ':controller/:action/:id'
end
