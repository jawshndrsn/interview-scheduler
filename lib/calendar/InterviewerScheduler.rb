class InterviewerScheduler
  def schedule(session, save = false)
    if(session.state == Session::UNSCHEDULED)
      all_interviewers = session.interviewer_pool.interviewers
      available = all_interviewers - session.rejected_interviewers
      
      if(available.empty?)
        session.state = Session::FAILED
      else
        interviewer = available.choice
        session.interviewer = interviewer
        session.state = Session::PENDING
      end
      
      # why does saving here cause trouble even when a tx started in enclosing scope?
      if(save)
        session.save!
      end
    end
  end
end
