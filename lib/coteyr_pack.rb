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

# CoteyrPack
require File.dirname(__FILE__) + '/restful.rb'
require File.dirname(__FILE__) + '/initilizers/exception_notifier.rb'
require File.dirname(__FILE__) + '/semantic_form_helper.rb'
require File.dirname(__FILE__) + '/semantic_form_builder.rb'
require File.dirname(__FILE__) + '/coteyr_form_helper.rb'
require File.dirname(__FILE__) + '/coteyr_form_builder.rb'

require File.join(File.dirname(__FILE__), 'restful-authentication', 'lib', "authentication")
require File.join(File.dirname(__FILE__), 'restful-authentication', 'lib', "authentication", "by_password")
require File.join(File.dirname(__FILE__), 'restful-authentication', 'lib', "authentication", "by_cookie_token")


require 'action_mailer'


#Include Validators
 Dir[File.join(File.dirname(__FILE__),'validators/*.rb')].each { |f| require f }
#Include rake tasks
class CoteyrPackTask < Rails::Railtie
  rake_tasks do
    Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
  end
end
