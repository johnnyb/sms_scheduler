class CreateScheduledMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :scheduled_messages do |t|
      t.string :source_type
      t.string :source_subtype
      t.text :source_url
      t.text :destination_phone
      t.text :source_phone
      t.string :requestor_ip_address
      t.string :time_zone
      t.text :message
      t.text :requested_by_name
      t.timestamp :send_at
      t.timestamp :sent_at
      t.string :status_code
      t.text :status_message
      t.timestamps
    end
  end
end
