if Rails.env == 'production'
	TWILIO_SID = 'production_sid'
	TWILIO_AUTH_TOKEN = 'production_auth'
	TWILIO_FROM_PHONE = '+1prodphone'
else
	TWILIO_SID = 'testing_sid'
	TWILIO_AUTH_TOKEN = 'testing_auth'
	TWILIO_FROM_PHONE = '+1testphone'
end
