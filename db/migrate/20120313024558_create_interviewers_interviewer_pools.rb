class CreateInterviewersInterviewerPools < ActiveRecord::Migration
  def up
    create_table :interviewers_interviewer_pools, :id => false do |t|
      t.references :interviewer
      t.references :interviewer_pool
    end
    add_index :interviewers_interviewer_pools, [:interviewer_id, :interviewer_pool_id], :name => 'iip_i_ip'
    add_index :interviewers_interviewer_pools, [:interviewer_pool_id, :interviewer_id], :name => 'iip_ip_i'
  end

  def down
    drop table :interviewers_interviewer_pools
  end
end
