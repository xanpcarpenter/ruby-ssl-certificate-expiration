#~/usr/bin/ruby
require 'certcheck.rb'

time = Time.now.getutc

# clear the old log files
File.open('https.log', 'w') {|file| file.truncate(0) }
File.open('https.expire', 'w') {|file| file.truncate(0) }
#File.open('expiration_report.txt', 'w') {|file| file.truncate(0) }
File.open('expiration_report.txt', 'w') {|file| file.write("This is an automated report.  It was generated on #{time} \r\n \r\nPlease contact the Xantrion NOC if you have any questions.\r\n\r\nThe following SSL Certs are due to expire in the next 30 days:\r\n\r\n") }

# open the text file and pass each name to the cert check method
text=File.read("sites.txt").split("\n")
text.each do |sitename|
	certificate_check("#{sitename}")
end

# Open the log file
#
#results=File.read("https.log").split("\n")

expiring_input = File.read('https.expire')
output = File.open('expiration_report.txt', 'a')
output.write(expiring_input)
output.write("-----------------------\r\n\r\n\r\n\r\n\r\nThe following certs were tested:\r\n\r\n")
log_input = File.read('https.log')
output.write(log_input)
output.close
require 'email.rb'
send_email

	
