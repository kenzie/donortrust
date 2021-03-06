class Pledge < ActiveRecord::Base
  include UserTransactionHelper

  belongs_to :participant
  belongs_to :team
  belongs_to :campaign
  belongs_to :order
  belongs_to :user
  belongs_to :admin_user, :class_name => 'User'
  has_one :pledge_deposit

  has_one :user_transaction, :as => :tx

  validates_presence_of :amount
  validates_numericality_of :amount
  validates_presence_of :pledger, :pledger_email, :unless => Proc.new { |m| m.anonymous }
  validates_format_of   :pledger_email, :unless => Proc.new { |m| m.anonymous }, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "isn't a valid email address", :if => Proc.new{|m| m.pledger_email?}

  after_create :user_transaction_create, :deliver_notification
  
  attr_accessor :notification # anonymous, personal or public
  
  HUMAN_ATTRIBUTES = {
    :pledger => "Name",
    :pledger_email => "Email"
  }

  def self.human_attribute_name(attr)  
    HUMAN_ATTRIBUTES[attr.to_sym] || super  
  end

  # set the reader methods for the columns dealing with currency
  # we're using BigDecimal explicity for mathematical accuracy - it's better for currency
  def amount
    BigDecimal.new(read_attribute(:amount).to_s) unless read_attribute(:amount).nil?
  end
  
  def notification
    if self.anonymous?
      "anonymous"
    elsif self.public?
      "public"
    else
      "personal"
    end
  end
  
  def notification=(t)
    if t == "anonymous"
      self.anonymous = true
    elsif t == "personal"
      self.anonymous = false
      self.public = false
    else # public
      self.anonymous = false
      self.public = true
    end
  end

  def valid?
    if team.nil? and campaign.nil? and participant.nil?
      return false
    end
      
    if team
      unless team.campaign.valid?
        return false
      end
    end
      
    if campaign
      unless campaign.valid?
        return false
      end
    end
  
    return super
  end

  def pledgee
    if (self.participant != nil)
      return self.participant.name
    elsif (self.team != nil)
      return self.team.name
    elsif (self.campaign != nil)
      return self.campaign.name
    end

    return nil
  end
  
  def deliver_notification
    CampaignsMailer.deliver_pledge_notification self
  end
end
