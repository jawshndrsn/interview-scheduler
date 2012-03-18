class InterviewerPool < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :interviewer_pool_memberships, :dependent => :destroy
  has_many :interviewers, :through => :interviewer_pool_memberships
  
  #has_and_belongs_to_many :interviewers
  accepts_nested_attributes_for :interviewers
end
