require 'smtp-tls'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "some.domain",
   :authentication => :plain,
   :user_name => "someuser@domain.com",  # don't put "@gmail.com" here, just your username
   :password => "password", #this is public
   :enable_starttls_auto => true }