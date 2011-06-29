# Copyright (c) 2010 by Robert D. Cotey II
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

# Include hook code here
require File.dirname(__FILE__) + '/lib/coteyr_pack.rb'
require File.dirname(__FILE__) + '/lib/restful.rb'
require File.dirname(__FILE__) + '/lib/semantic_form_builder.rb'
require File.dirname(__FILE__) + '/lib/semantic_form_helper.rb'
require File.join(File.dirname(__FILE__), "lib", 'restful-authentication', 'lib', "authentication")
require File.join(File.dirname(__FILE__), "lib", 'restful-authentication', 'lib', "authentication", "by_password")
require File.join(File.dirname(__FILE__), "lib", 'restful-authentication', 'lib', "authentication", "by_cookie_token")
require File.expand_path(File.join(File.dirname(__FILE__), %w(lib fleximage)))

require 'action_mailer'
#require File.dirname(__FILE__) + '/lib/exception_notifier.rb'
#require File.dirname(__FILE__) + '/lib/exception_notifiable.rb'
#require File.dirname(__FILE__) + '/lib/exception_notifier_helper.rb'
