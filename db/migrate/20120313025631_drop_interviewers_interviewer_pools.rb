class DropInterviewersInterviewerPools < ActiveRecord::Migration
  def up
    drop_table :interviewers_interviewer_pools
  end
end
