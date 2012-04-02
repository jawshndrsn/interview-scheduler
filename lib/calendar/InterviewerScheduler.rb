class InterviewerScheduler
  def initialize(calendar)
    @calendar = calendar
  end

  def schedule(session, save = false)
    if(session.state == Session::UNSCHEDULED)
      create_cal_event(session)
      
      # why does saving here cause trouble even when a tx started in enclosing scope?
      if(save)
        session.save!
      end
    end
  end
  
  def update_status(session)
    # This assumes only one attendee (ie interviewer) per calendar entry
  
    case session.state
    when Session::PENDING
      # Haven't heard back from interviewer
      if session.external_id.nil?
        create_cal_event(session)
        session.save!
      else session.external_id.nil?
        event = @calendar.event(session.external_id)
        case event.attendees[0][:state]
        when Event::ATTENDING
          session.state = Session::CONFIRMED
          session.save!
        when Event::DECLINED
          reschedule(session)
        end
      end
    when Session::CONFIRMED
      # Interviewer could have decided to cancel the event in their calendar
      event = @calendar.event(session.external_id)
      case event.attendees[0][:state]
      when Event::PENDING
        session.state = Session::PENDING
        session.save!
      when Event::DECLINED
        reschedule(session)
      end
    end
  end
  
  private
  def create_cal_event(session)
    all_interviewers = session.interviewer_pool.interviewers
    available = all_interviewers - session.rejected_interviewers
      
    if(available.empty?)
      session.state = Session::FAILED
    else
      interviewer = available.sample
      session.interviewer = interviewer
      session.state = Session::PENDING
      
      event = Event.new("Interview: #{session.panel.candidate}", session.start, session.end, [{:email => interviewer.email, :status => Event::PENDING}])
      created = @calendar.create_event(event)
      session.external_id = created.id
    end
  end
  
  def reschedule(session)
    event = @calendar.event(session.external_id)
    @calendar.delete_event(event)
    session.rejected_interviewers << session.interviewer if !session.interviewer.nil?
    session.interviewer = nil
    session.external_id = nil
    
    create_cal_event(session)
    session.save!
  end
end
