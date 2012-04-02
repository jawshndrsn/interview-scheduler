require './app/models/interviewer.rb'

class Session < ActiveRecord::Base
  UNSCHEDULED = 0 # hasn't been assigned an interviewer yet
  PENDING     = 1 # interviewer calendar invite not accepted yet
  CONFIRMED   = 2 # interviewer calendar invite confirmed
  FAILED      = 3 # all interviewers declined

  validates :panel,             :presence => true
  validates :interviewer_pool,  :presence => true
  validates :state,             :presence => true
  validates :start,             :presence => true
  validates :end,               :presence => true
  
  belongs_to :panel
  belongs_to :interviewer_pool
  belongs_to :interviewer
  has_and_belongs_to_many :rejected_interviewers, :class_name => 'Interviewer', :join_table => :sessions_rejected_interviewers
  
  after_initialize :init
  
  def init
    self.rejected_interviewers ||= []
  end
  
  # this can't be the best way to do this
  def self.stateName(state)
    case state
    when UNSCHEDULED then "UNSCHEDULED"
    when PENDING then "PENDING"
    when CONFIRMED then "CONFIRMED"
    when FAILED then "FAILED"
    end
  end
end
