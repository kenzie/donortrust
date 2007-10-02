require 'acts_as_paranoid_versioned'
class Project < ActiveRecord::Base
acts_as_simile_timeline_event(
    :fields =>
    {
      :start       => :start_date,
      :title       => :name,
      :description => :description
    }
  )
 acts_as_paranoid_versioned
 
  belongs_to :project_status
  belongs_to :program
  belongs_to :partner
  belongs_to :place
  belongs_to :contact
  belongs_to :rss_feed
  has_many :milestones, :dependent => :destroy
  has_many :project_you_tube_videos, :dependent => :destroy
  has_many :project_flickr_images, :dependent => :destroy
  has_many :you_tube_videos, :through => :project_you_tube_videos
  has_many :flickr_images, :through => :project_flickr_images
  has_many :ranks
  has_many :investments
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :sectors
  
 
  validate do |me|
    # In each of the 'unless' conditions, true means that the association is reloaded,
    # if it does not exist, nil is returned
    unless me.program( true )
      me.errors.add :program_id, 'does not exist'
    end
    unless me.partner( true )
      me.errors.add :partner_id, 'does not exist'
    end
    unless me.project_status( true )
      me.errors.add :project_status_id, 'does not exist'
    end
  end
  
  def milestone_count
    return milestones.count
  end
  
  def milestones_count
    return Milestone.find(:all).size
  end
  
  def self.total_percent_raised
    percent_raised = 100
    unless self.total_costs == nil or self.total_costs == 0
      percent_raised = self.total_money_raised * 100 / self.total_costs      
      if percent_raised > 100 then percent_raised = 100 end
    end
    percent_raised
  end 
  
  def get_number_of_milestones_by_status(status)
    milestones = self.milestones.find(:all, :conditions => {:milestone_status_id => status.to_s } )
    return milestones.size unless milestones == nil     
  end
  
  def days_remaining
    result = nil
    result = end_date - Date.today if end_date != nil
    result = 0 if result != nil && result < 0
    return result
  end
  
  def village_id
    self.place_id
  end
  
  def village_id?
    self.place_id?
  end

  def nation_id
    self.nation if !@nation
    return @nation ? @nation.id : nil
  end

  def nation_id?
    self.nation if !@nation
    return @nation ? @nation.id? : false
  end

  def village
    @village = self.place if self.place_id?
  end
  
  def village_project_count
    self.village.projects.size
  end
  
  def nation(node = nil)
    if @nation.nil?
      node = self.village if !node
      return @nation = nil if !node
      node = node.parent while node.parent && node.parent.place_type_id != 2
      @nation = node.parent if node.parent.place_type_id == 2
    end
    @nation
  end
  
  def current_need
    self.total_cost - self.dollars_raised
  end
   
  def get_percent_raised
    percent_raised = 0
    if self.total_cost > 0 then
      percent_raised = (dollars_raised * 100 / total_cost)
      if percent_raised > 100 then percent_raised = 100 end
    end
    return percent_raised
  end
  
  
  def self.projects_nearing_end(days_until_end)
    @projects = Project.find(:all, :conditions => ["(end_date BETWEEN ? AND ?)", Time.now, days_until_end.days.from_now])
  end
  
  def get_all_you_tube_videos
    @you_tube_videos = Array.new
    for project_you_tube_video in self.project_you_tube_videos
      @you_tube_videos.push(project_you_tube_video.you_tube_video)
    end
    @you_tube_videos
  end
  
  def self.total_money_raised
    return self.sum(:dollars_raised)
  end
  
  def self.total_costs
    return self.sum(:total_cost)
  end
  
  def self.total_money_spent
    return self.sum(:dollars_spent)
  end
end
