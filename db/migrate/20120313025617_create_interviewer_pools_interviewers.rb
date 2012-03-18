class CreateInterviewerPoolsInterviewers < ActiveRecord::Migration
  def up
    create_table :interviewer_pools_interviewers, :id => false do |t|
      t.references :interviewer_pool
      t.references :interviewer
    end
    add_index :interviewer_pools_interviewers, [:interviewer_pool_id, :interviewer_id], :name => 'ipi_ip_i'
    add_index :interviewer_pools_interviewers, [:interviewer_id, :interviewer_pool_id], :name => 'ipi_i_ip'
  end

  def down
    drop table :interviewer_pools_interviewers
  end
end
