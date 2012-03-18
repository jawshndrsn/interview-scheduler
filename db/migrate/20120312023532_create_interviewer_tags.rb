class CreateInterviewerTags < ActiveRecord::Migration
  def change
    create_table :interviewer_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
