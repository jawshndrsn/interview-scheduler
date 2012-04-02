class CreateCalendarCredentials < ActiveRecord::Migration
  def change
    create_table :calendar_credentials do |t|
      t.string :name
      t.string :authorization_code

      t.timestamps
    end
  end
end
