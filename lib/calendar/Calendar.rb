class Calendar
  #def create_event(event)
  
  #def user_is_free?(email, start_time, end_time)
  
  #def delete_event(event)
end

class Event
  ATTENDING = 0
  DECLINED  = 1
  PENDING   = 2
  
  attr_accessor :id, :summary, :start_time, :end_time, :attendees
  
  def initialize(summary, start_time, end_time, attendees)
    @id = nil
    @summary = summary
    @start_time = start_time
    @end_time = end_time
    @attendees = attendees
  end
  
  def attendees_state?(state)
    # better way than creating new array?
    (@attendees.select {|a| a[:state] != state}).empty?
  end
end
