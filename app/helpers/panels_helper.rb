module PanelsHelper
  def sessionTimeLabel(from, to)
    from.to_s + ":00 to " + to.to_s + ":00"
  end
  
  def poolNames
    InterviewerPool.all.map {|p| [p.name, p.id]}
  end
  
  def panelState(panel)
    states = panel.sessions.map { |s| s.state }
    if(states.index {|s| s != Session::CONFIRMED}.nil?)
      "ok"
    elsif(!states.index(Session::FAILED).nil?)
      "error"
    else
      "pending"
    end
  end
end
