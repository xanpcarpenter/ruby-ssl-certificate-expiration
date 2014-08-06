#!/usr/local/bin/ruby
require 'net/https'

expire_within_days = 30
url = "https://google.com/"
proxy_addr = 'http-proxy.com'
proxy_port = 8080

uri = URI.parse(url)
http = Net::HTTP.new(uri.host,uri.port,proxy_addr,proxy_port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
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

puts "current time is: #{Time.now.to_i}"
puts "#{expire_within_days} days from now is: #{(Time.now + (expire_within_days * 24*60*60)).to_i}"

# check if cert expire time is less than expire_within_days. Fail if true.
if @cert.not_after.to_i < (Time.now + (expire_within_days * 24*60*60)).to_i
  puts "Certificate expires at: #{@cert.not_after}"
  exit 1
end