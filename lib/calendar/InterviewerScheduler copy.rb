class InterviewerScheduler
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

  # private?
  def calendarId(summary)
    result = @gclient.execute(:api_method => @capi.calendar_list.list)
    raise "Error finding calendar: #{result.data.to_json}" if !result.data['error'].nil?
    n = result.data.items.index{|i| i.summary == summary}
    n.nil? ? nil : result.data.items[n].id
  end

  def schedule(session, save = false)
    if(session.state == Session::UNSCHEDULED)
      all_interviewers = session.interviewer_pool.interviewers
      available = all_interviewers - session.rejected_interviewers
      
      if(available.empty?)
        session.state = Session::FAILED
      else
        interviewer = available.sample
        session.interviewer = interviewer
        session.state = Session::PENDING
        
        event = {'summary' => "Interview: #{session.panel.candidate}",
                 'start' => {'dateTime' => session.start.rfc3339 },
                 'end' => {'dateTime' => session.end.rfc3339 },
                 'attendees' => [{'email' => interviewer.email}]}
        result = @gclient.execute(:api_method => @capi.events.insert, 
                                  :parameters => { 'calendarId' => @calendarId },
                                  :body => JSON.dump(event),
                                  :headers => {'Content-Type' => 'application/json'})
        raise "Error creating event: #{result.data.to_json}" if !result.data['error'].nil?
      end
      
      # why does saving here cause trouble even when a tx started in enclosing scope?
      if(save)
        session.save!
      end
    end
  end
end
