def certificate_check (arg1)
	require 'net/https'
	expire_within_days = 30
	url = "#{arg1}"
	#proxy_addr = 'http-proxy.com'
	#proxy_port = 8080

	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host,uri.port) #removed proxy variables methods
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	puts "Connecting to #{url}"
	http.start do |h|
  	@cert = h.peer_cert
	end

	# available fields in certificate
	#puts <<EOD
	#  Subject: #{@cert.subject}
	#  Issuer:  #{@cert.issuer}
	#  Serial:  #{@cert.serial}
	#  Issued:  #{@cert.not_before}
	#  Expires: #{@cert.not_after}
	#EOD

	#puts "current time is: #{Time.now.to_i}"
	#puts "#{expire_within_days} days from now is: #{(Time.now + (expire_within_days * 24*60*60)).to_i}"

	# Open the log file and record the days remaining for each certificate checked.
	days_remaining = @cert.not_after.to_i - Time.now.to_i
	File.open('https.log', 'a') do |f|
		f.write "The certificate for #{url} expires in #{days_remaining / (60*60*24).to_i} days.\r\n"
	end

	# check if cert expire time is less than expire_within_days. Fail if true and write to expire file.
	if @cert.not_after.to_i < (Time.now + (expire_within_days * 24*60*60)).to_i
  		File.open('https.expire', 'a') do |f|
		f.write "The certificate for #{url} expires in #{days_remaining / (60*60*24).to_i} days on #{@cert.not_after}.\r\n"
  		end
	end

end
