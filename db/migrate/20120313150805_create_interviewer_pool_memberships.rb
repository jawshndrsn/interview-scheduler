class CreateInterviewerPoolMemberships < ActiveRecord::Migration
  def change
    create_table :interviewer_pool_memberships do |t|
      t.references :interviewer
      t.references :interviewer_pool

      t.timestamps
    end
    add_index :interviewer_pool_memberships, :interviewer_id
    add_index :interviewer_pool_memberships, :interviewer_pool_id
  end
end
