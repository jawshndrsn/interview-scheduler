require './lib/calendar/Calendar'

class GoogleCalendar < Calendar
  def initialize(google_data_client)
    @gclient = google_data_client
    
    @gclient.authorization.fetch_access_token! if @gclient.authorization.access_token.nil? || @gclient.authorization.expired?
    @capi = @gclient.discovered_api('calendar', 'v3')
    
    # Create the calendar if necessary
    @calendarId = calendarId('Interviews')
    if(@calendarId.nil?)
      puts 'Creating Interviews calendar'
      insert = @gclient.execute(:api_method => @capi.calendar_list.insert, :parameters => {'id' => 'Interviews'})
      raise "Error creating calendar: #{insert.data.to_json}" if !insert.data['error'].nil?
    end
  end

  def create_event(event)
    attendees = event.attendees.map {|a| {'email' => a[:email]}}
    event_map = {'summary' => event.summary,
                 'start' => {'dateTime' => event.start_time.to_datetime.rfc3339 },
                 'end' => {'dateTime' => event.end_time.to_datetime.rfc3339 },
                 'attendees' => attendees}
    result = @gclient.execute(:api_method => @capi.events.insert, 
                              :parameters => {'calendarId' => @calendarId,
                                              'sendNotifications' => 'true'},
                              :body => JSON.dump(event_map),
                              :headers => {'Content-Type' => 'application/json'})
    raise "Error creating event: #{result.data.to_json}" if !result.data['error'].nil?
    event.id = result.data.id
    event
  end
  
  def user_is_free?(email, start_time, end_time)
    # make this better
    true
  end
  
  def event(id)
    result = @gclient.execute(:api_method => @capi.events.get, 
                              :parameters => {'calendarId' => @calendarId,
                                              'eventId' => id})
    raise "Error getting event: #{result.data.to_json}" if !result.data['error'].nil?
    
    data = result.data
    summary = data.summary
    start_time = data.start.dateTime
    end_time = data.end.dateTime
    
    attendees = data.attendees.map {|a| {:email => a.email, :state => GoogleCalendar.fromGoogleAttendanceStatus(a.responseStatus)}}
    
    event = Event.new(summary, start_time, end_time, attendees)
    event.id = id
    event
  end
  
  def delete_event(event)
    result = @gclient.execute(:api_method => @capi.events.delete, 
                              :parameters => { 'calendarId' => @calendarId,
                                               'eventId' => event.id })
    raise "Error deleting event: #{result.data.to_json}" if !result.body.nil? && !result.data['error'].nil?
  end
  
  def freebusy(usersOrCalendarIds, from, to)
    items = usersOrCalendarIds.map {|uc| {'id' => uc}}
    
    fb_map = {'timeMin' => from.to_datetime.rfc3339,
              'timeMax' => to.to_datetime.rfc3339,
              'items' => items}
    result = @gclient.execute(:api_method => @capi.freebusy.query,
                              :body => JSON.dump(fb_map),
                              :headers => {'Content-Type' => 'application/json'})
    raise "Error getting freebusy for #{usersOrCalendarIds}: #{result.data.to_json}" if !result.data['error'].nil?
    
    cals = result.data['calendars']
    tuples = usersOrCalendarIds.map {|uc|
      c = cals[uc]
      raise "Error getting freebusy for #{uc}: #{c.errors}" if !c.errors.empty?
      [uc, c.busy.empty?]
    }
    
    Hash[tuples]
  end
  
  private
  def calendarId(summary)
    result = @gclient.execute(:api_method => @capi.calendar_list.list)
    raise "Error finding calendar: #{result.data.to_json}" if !result.data['error'].nil?
    n = result.data.items.index{|i| i.summary == summary}
    n.nil? ? nil : result.data.items[n].id
  end
  
  def self.fromGoogleAttendanceStatus(gstatus)
    case gstatus
    when "accepted"
      Event::ATTENDING
    when "declined"
      Event::DECLINED
    else
      Event::PENDING
    end
  end
end
