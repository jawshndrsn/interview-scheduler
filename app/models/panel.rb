require 'valid_email'

class Panel < ActiveRecord::Base
  validates :candidate, :presence => true
  validates :email,     :presence => true, :email => true
  validates :position,  :presence => true
  validates :date,      :presence => true

  has_many :sessions
end
