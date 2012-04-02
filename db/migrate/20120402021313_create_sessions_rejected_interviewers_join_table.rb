class CreateSessionsRejectedInterviewersJoinTable < ActiveRecord::Migration
  def change
    create_table :sessions_rejected_interviewers, :id => false do |t|
      t.integer :session_id
      t.integer :interviewer_id
    end
  end
end
