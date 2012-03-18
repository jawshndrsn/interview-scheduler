module InterviewerPoolsHelper
  def has_interviewer(pool, interviewer)
    pool.interviewers.include?(interviewer)
  end
end
