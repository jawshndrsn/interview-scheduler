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
  has_and_belongs_to_many :rejected_interviewers, :class_name => :interviewer
  
  after_initialize :init
  
  def init
    self.rejected_interviewers ||= []
  end
end
