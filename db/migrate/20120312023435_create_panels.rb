class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :candidate
      t.string :email
      t.string :position
      t.date :date

      t.timestamps
    end
  end
end
