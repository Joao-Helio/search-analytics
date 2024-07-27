class AddUserIdToSearchLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :search_logs, :user_id, :integer
    add_index :search_logs, :user_id
  end
end
