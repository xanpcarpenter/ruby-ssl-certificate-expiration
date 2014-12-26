#~/usr/bin/ruby
require 'certcheck.rb'

text=File.read("sites.txt").split("\n")
text.each do |sitename|
	certificate_check("#{sitename}")
end
