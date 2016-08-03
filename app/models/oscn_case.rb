class OscnCase
	attr_accessor :original_document, :plaintiff, :defendant, :events, :case_number

	def initialize(val)
		@case_number = val
	end

	def to_json
		{
			:plaintiff => @plaintiff,
			:defendant => @defendant,
			:events => @events
		}.to_json
	end

	def source_url
		"http://www.oscn.net/dockets/GetCaseInformation.aspx?db=tulsa&number=#{@case_number}"
	end

	# Integer#chr not working - this does
	# http://stackoverflow.com/questions/10304754/ruby-1-9-what-is-easiest-inverse-of-string-codepoints-to-a
	def unicode_chr(val)
		[val].inject('') {|s, cp| s << cp }
	end


	def load!
		doc = HTTParty.get(source_url, :timeout => 60).body
		@original_document = doc
		spacea = unicode_chr(32)
		spaceb = unicode_chr(160)
		spaces = "\\s#{spacea}#{spaceb}"
		@plaintiff = $1 if doc =~ />(.*?),<br \/>[#{spaces}]*Plaintiff,/

		@defendant = $1 if doc =~ /v\.<br \/>[#{spaces}]*(.*?),<br \/>[#{spaces}]*Defendant\./

		event_section = $1 if doc =~ /<h2.*?>Events.*?<\/h2>.*?<tbody>(.*?)<\/tbody>/m
		events_html = event_section.split("<tr>")
		events_html.shift # First one is junk
		@events = events_html.map do |evt_html| 
			evt_html = evt_html.split("<td>")
			date_and_evt = evt_html[1]
			date = $1 if date_and_evt =~ /<font.*?>(.*?)<\/font>/m
			event = $1 if date_and_evt =~ /<\/font><br>[#{spaces}]*(.*?)</m
			party = $1 if evt_html[2] =~ /(.*?)</m
			party = party.gsub("&nbsp;", " ")
			docket = $1 if evt_html[3] =~ /[#{spaces}]*(.*?)</m
			{
				:date => (Time.parse(date) rescue "ERR"),
				:event => event,
				:party => party,
				:docket => docket
			}
		end
	end
end
