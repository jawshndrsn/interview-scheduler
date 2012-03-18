require 'valid_email'

class Interviewer < ActiveRecord::Base
  validates :name,  :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true
  
  has_many :interviewer_pool_memberships, :dependent => :destroy
  has_many :interviewer_pools, :through => :interviewer_pool_memberships
end
