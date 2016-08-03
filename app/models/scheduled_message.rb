class ScheduledMessage < ApplicationRecord
	scope :ready, ->{where("send_at <= CURRENT_TIMESTAMP and sent_at IS NULL")}
	scope :for_source_url, ->(u){where(:source_url => u)}
	scope :send_at_order, ->{order(:send_at)}

	def twilio_client
		@@client ||= Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
		return @@client
	end

	def self.send_available_messages
		ScheduledMessage.ready.each do |msg|
			msg.send_now!
		end
	end

	def send_now!
		self.twilio_client.account.messages.create({
			:to => destination_phone,
			:from => TWILIO_FROM_PHONE,
			:body => message
		})
	end
end
