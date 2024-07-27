class AddQuerySegmentsToSearchLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :search_logs, :query_segments, :text, array: true, default: []
    add_index :search_logs, :ip_address
    add_index :search_logs, :created_at
  end
end
