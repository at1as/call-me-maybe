class RenameConversationScheduledTimeToStartTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :conversations, :scheduled_time, :start_time
  end
end
