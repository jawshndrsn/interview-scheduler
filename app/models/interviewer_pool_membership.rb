class InterviewerPoolMembership < ActiveRecord::Base
  belongs_to :interviewer
  belongs_to :interviewer_pool
  
  validates :interviewer_id, :presence => true
  validates :interviewer_pool_id, :presence => true
end
