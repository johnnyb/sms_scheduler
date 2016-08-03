class ScheduledMessagesController < ApplicationController
	def massage_phone_number(ph)
		ph = ph.gsub("[^\d\+]+", "")
		if ph[0] != "+"
			if ph[0] == "1"
				ph = "+#{ph}"
			else
				ph = "+1#{ph}"
			end
		end
		return ph
	end

	def create
		msglist = []
		params[:phone_numbers].split(/,\s*/).each do |ph|
			ph = massage_phone_number(ph)
			msg = ScheduledMessage.create!(:source_type => params[:source_type], :source_subtype => params[:source_subtype], :source_url => params[:source_url], :destination_phone => ph, :requestor_ip_address => request.remote_ip, :message => params[:message], :send_at => params[:send_at])
			msglist.push(msg)
		end
		render :json => msglist.to_json
	end
end
