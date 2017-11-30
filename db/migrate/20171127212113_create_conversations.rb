class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.string :guest_email
      t.string :video_url
      t.datetime :reminder
      t.datetime :scheduled_time
      t.text :message

      t.timestamps
    end
  end
end
