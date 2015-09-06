class AddsBrowserColumn < ActiveRecord::Migration
  def change
    add_column :payloads, :user_agent_string, :text

  end
end
