class PartnerStatus < ActiveRecord::Base
   validates_presence_of :name
  validates_uniqueness_of :name
  


  validates_presence_of :statusType
  validates_length_of :statusType, :maximum => 25
  validates_length_of :description, :maximum => 250
  
  def to_label
    "#{statusType}"
  end
end
