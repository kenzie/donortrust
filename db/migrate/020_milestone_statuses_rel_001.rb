require 'active_record/fixtures'

class MilestoneStatusesRel001 < ActiveRecord::Migration
  def self.up
    create_table :milestone_statuses do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
    end #milestone_statuses
    
    if (ENV['RAILS_ENV'] == 'development')
      directory = File.join(File.dirname(__FILE__), "dev_data")
      Fixtures.create_fixtures(directory, "milestone_statuses")
    end
  end
  
  def self.down
    drop_table :milestone_statuses 
  end
end