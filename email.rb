def send_email() 
require 'net/smtp'

filename = "expiration_report.txt"
# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m") 	#base 64

marker = "AUNIQUEMARKER"

body =<<EOF
This is a sample automated e-mail that could be sent on a regular interval.\r\n
EOF

# Define the main headers.
part1 =<<EOF
From: Certificate Bot <no-reply@xantrion.com>
To: Patrick Carpenter <pcarpenter@xantrion.com>
Subject: Certificate Expiry Report
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit

#{body}
--#{marker}
EOF

# Define the attachment section
part3 =<<EOF
Content-Type: multipart/mixed; name=\"#{filename}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{filename}"

#{encodedcontent}
--#{marker}--
EOF

mailtext = part1 + part2 + part3

# Let's put our code in safe area
begin 
  Net::SMTP.start('xan-den-ex01.xantrion-hq.local') do |smtp|
       smtp.sendmail(mailtext, 'no-reply@xantrion.com',
                                 ['pcarpenter@xantrion.com'])
  end
rescue Exception => e  
    print "Exception occured: " + e  
end  
end
