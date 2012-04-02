class AddExternalIdToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :external_id, :string
  end
end
