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

class ControllerGenerator < Rails::Generator::NamedBase
  attr_accessor :models_name, :model_name, :controller_name, :underscore_name
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      @controller_name = "#{@class_name}Controller"
      @underscore_name = @class_name.underscore.downcase
      @models_name = @class_name.downcase
      @model_name = @class_name.singularize
      m.directory('app/controllers')
      m.directory('app/helpers')
      m.directory('app/views')
      m.directory(File.join('app/views',@underscore_name))
      m.template('index.rb', File.join('app/views',@underscore_name, '/index.html.erb'))
      m.template('new.rb', File.join('app/views',@underscore_name, '/new.html.erb'))
      m.template('edit.rb', File.join('app/views',@underscore_name, '/edit.html.erb'))
      m.template('show.rb', File.join('app/views',@underscore_name, '/show.html.erb'))
      m.template('_single.rb', File.join('app/views',@underscore_name, "_#{@underscore_name.singularize}.html.erb"))
      m.template('_form.rb', File.join('app/views',@underscore_name, '/_form.html.erb'))
      m.template('controller.rb',"app/controllers/#{@underscore_name}_controller.rb")
      m.template('helper.rb',"app/helpers/#{@underscore_name}_helper.rb")
      m.route_resources @underscore_name
      m.directory('test/functional')
      m.template('controller_test.rb',"test/functional/#{@underscore_name}_controller_test.rb")
    end
  end
end
