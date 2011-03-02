# Copyright (c) 2010 Robert D. Cotey II
# Orignal version Copyright © 2008 Alex Wayne beautifulpixel.com, released under the MIT license.
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
require 'open-uri'
require 'base64'
require 'digest/sha1'
require 'aws/s3'

# Load RMagick
begin
  require 'RMagick'
rescue MissingSourceFile => e
  puts %{ERROR :: FlexImage requires the RMagick gem.  http://rmagick.rubyforge.org/install-faq.html}
  raise e
end

# Apply a few RMagick patches
require 'fleximage/rmagick_image_patch'

# Load dsl_accessor from lib
require 'dsl_accessor'

# Load Operators
require 'fleximage/operator/base'
Dir.entries("#{File.dirname(__FILE__)}/fleximage/operator").each do |filename|
  require "fleximage/operator/#{filename.gsub('.rb', '')}" if filename =~ /\.rb$/
end

# Setup Model
require 'fleximage/model'
ActiveRecord::Base.class_eval { include Fleximage::Model }

# Image Proxy
require 'fleximage/image_proxy'

# Setup View
#ActionController::Base.exempt_from_layout :flexi
if defined?(ActionView::Template)
  # Rails >= 2.1
  if Rails.version.to_f >= 3 
    require 'fleximage/rails3_view'
    ActionView::Template.register_template_handler :flexi, ActionView::TemplateHandlers::Rails3View
  else
    require 'fleximage/view'
    ActionView::Template.register_template_handler :flexi, Fleximage::View
  end
else
  # Rails < 2.1
  require 'fleximage/legacy_view'
  ActionView::Base.register_template_handler :flexi, Fleximage::LegacyView
end

# Setup Helper
require 'fleximage/helper'
ActionView::Base.class_eval { include Fleximage::Helper }

# Setup Aviary Controller
require 'fleximage/aviary_controller'
ActionController::Base.class_eval{ include Fleximage::AviaryController }

# Register mime types
Mime::Type.register_alias "image/pjpeg", :jpg # IE6 sends jpg data as "image/pjpeg".  Silly IE6.
#Mime::Type.register "image/jpeg", :jpg
Mime::Type.register "image/gif", :gif
Mime::Type.register "image/png", :png