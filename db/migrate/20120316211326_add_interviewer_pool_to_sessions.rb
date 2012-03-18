class AddInterviewerPoolToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :interviewer_pool_id, :interviewer_pool_id
  end
end
