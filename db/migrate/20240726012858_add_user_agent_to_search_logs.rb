class AddUserAgentToSearchLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :search_logs, :user_agent, :string
  end
end
