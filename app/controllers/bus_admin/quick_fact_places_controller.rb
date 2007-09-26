class BusAdmin::QuickFactPlacesController < ApplicationController

   active_scaffold :quick_fact_places do |config|
    config.label = "Quick Facts"
    config.columns = [ :quick_fact,:description, :place]    
    config.columns[ :quick_fact ].form_ui = :select
    config.columns[ :place ].form_ui = :select    
    update.columns.exclude [:place]

  end

end