# Copyright (c) 2017 by Muhammad Yawar Ali
#    This file is part of coteyr_pack.
#
#    coteyr_pack is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    coteyr_pack is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with coteyr_pack.  If not, see <http://www.gnu.org/licenses/>.

#require 'smtp-tls' #use if your on ruby < 1.8.7 and want tls support

#sample gmail config from the net
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#   address: "smtp.gmail.com",
#   port: 587,
#   domain: "some.domain",
#   authentication: :plain,
#   user_name: "someuser@domain.com",  # make sure to put "@gmail.com" here, not just your username
#   password: "password", #this is public
#   enable_starttls_auto: true }
