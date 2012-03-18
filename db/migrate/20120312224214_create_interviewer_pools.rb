class CreateInterviewerPools < ActiveRecord::Migration
  def change
    create_table :interviewer_pools do |t|
      t.string :name
      t.references :interviewers

      t.timestamps
    end
    add_index :interviewer_pools, :interviewers_id
  end
end
