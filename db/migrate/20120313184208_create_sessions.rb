class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :panel
      t.datetime :start
      t.datetime :end
      t.references :interviewer
      t.references :rejected_interviewers
      t.integer :state

      t.timestamps
    end
    add_index :sessions, :panel_id
    add_index :sessions, :interviewer_id
    add_index :sessions, :rejected_interviewers_id
  end
end
