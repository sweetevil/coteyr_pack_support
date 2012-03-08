# Copyright (c) 2010 Robert D. Cotey II
# Orignal version Copyright © 2008 Alex Wayne beautifulpixel.com, released under the MIT license.
# Updated from https://github.com/tvdeyen/fleximage (03-18-2012)
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

module Fleximage
  
  # Renders a .flexi template
  class LegacyView #:nodoc:
    class TemplateDidNotReturnImage < RuntimeError #:nodoc:
    end
    
    def initialize(view)
      @view = view
    end
    
    def render(template, local_assigns = {})
      # process the view
      result = @view.instance_eval do
        
        # Shorthand color creation
        def color(*args)
          if args.size == 1 && args.first.is_a?(String)
            args.first
          else
            Magick::Pixel.new(*args)
          end
        end
        
        # inject assigns into instance variables
        assigns.each do |key, value|
          instance_variable_set "@#{key}", value
        end
        
        # inject local assigns into reader methods
        local_assigns.each do |key, value|
          class << self; self; end.send(:define_method, key) { value }
        end
        
        #execute the template
        eval(template)
      end
      
      # Raise an error if object returned from template is not an image record
      unless result.class.include?(Fleximage::Model::InstanceMethods)
        raise TemplateDidNotReturnImage, ".flexi template was expected to return a model instance that acts_as_fleximage, but got an instance of <#{result.class}> instead."
      end
      
      # Figure out the proper format
      requested_format = (@view.params[:format] || :jpg).to_sym
      raise 'Image must be requested with an image type format.  jpg, gif and png only are supported.' unless [:jpg, :gif, :png].include?(requested_format)
      
      # Set proper content type
      @view.controller.headers["Content-Type"] = Mime::Type.lookup_by_extension(requested_format.to_s).to_s
      
      # get rendered result
      rendered_image = result.output_image(:format => requested_format)
      
      # Return image data
      return rendered_image
    ensure
    
      # ensure garbage collection happens after every flex image render
      rendered_image.dispose!
      GC.start
    end
  end
end
