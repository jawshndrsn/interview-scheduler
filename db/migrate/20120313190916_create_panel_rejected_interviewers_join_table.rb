class CreatePanelRejectedInterviewersJoinTable < ActiveRecord::Migration
  def change
    create_table :panel_rejected_interviewers, :id => false do |t|
      t.integer :panel_id
      t.integer :interviewer_id
    end
  end
end
