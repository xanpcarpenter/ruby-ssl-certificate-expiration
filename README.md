ruby-ssl-certificate-expiration
===============================

Quick script that will check a certificates expiration time and fail if within a certain number of days threshold. Can be used with Jenkins to fail a build when this threshold is met


xan-pcarpenter fork modifications:

Moved the original script.rb file to certcheck.rb.  Modded the script so that it would accept an https:// URL
as an ARG value passed to the script.  

The new program runs from master.rb and uses the values stored in sites.txt to perform a lookup on a list of 
URLs.  It outputs all tested URLs certificate expiration dates to a file.  Any certs due to expire under the
set threshold value (default 30 days) are logged to a seperate file.  The files are then combined into a single
report and e-mailed.  

It is possible to run this from a cron job and have a list of expiring certificates e-mailed to you
on a regular basis.


If you use this program, make sure you look through each file and verify your defaults and e-mail addresses.

Future work:

Move all variable values (e-mail adress, etc.) to master.rb an recode email.rb to accept these as arguments.
Make the e-mail look better (body section currently not working).
