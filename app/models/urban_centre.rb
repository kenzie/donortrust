class UrbanCentre < ActiveRecord::Base

  belongs_to  :region
  has_many :projects


  validates_presence_of :region_id
  validates_presence_of :name
  
  def validate
    begin
      Region.find(self.region_id)
    rescue ActiveRecord::RecordNotFound
      errors.add_to_base("Region with id=#{self.region_id} doesn't exist.")
    end
  end
  def to_label
    "#{name}"
  end
  
  def get_country
    country = self.region.country
  end
end

