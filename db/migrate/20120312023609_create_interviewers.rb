class CreateInterviewers < ActiveRecord::Migration
  def change
    create_table :interviewers do |t|
      t.string :name
      t.string :email
      t.references :interviewer_tags

      t.timestamps
    end
    add_index :interviewers, :interviewer_tags_id
  end
end
