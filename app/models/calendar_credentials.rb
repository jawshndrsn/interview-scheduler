class CalendarCredentials < ActiveRecord::Base
  validates :name,  :presence => true, :uniqueness => true
  validates :authorization_code, :presence => true
end
