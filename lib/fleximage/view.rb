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
module Fleximage

  # Renders a .flexi template
  class View < ActionView::TemplateHandler #:nodoc:
    class TemplateDidNotReturnImage < RuntimeError #:nodoc:
    end

    def self.call(template)
      "Fleximage::View.new(self).render(template)"
    end

    def initialize(action_view)
      @view = action_view
    end

    def render(template)
      # process the view
      result = @view.instance_eval do

        # Shorthand color creation
        def color(*args)
          Fleximage::Operator::Base.color(*args)
        end

        #execute the template
        eval(template.source)
      end

      # Raise an error if object returned from template is not an image record
      unless result.class.include?(Fleximage::Model::InstanceMethods)
        raise TemplateDidNotReturnImage,
                ".flexi template was expected to return a model instance that acts_as_fleximage, but got an instance of <#{result.class}> instead."
      end

      # Figure out the proper format
      requested_format = (@view.params[:format] || :jpg).to_sym
      unless [:jpg, :gif, :png].include?(requested_format)
        raise 'Image must be requested with an image type format.  jpg, gif and png only are supported.'
      end

      # Set proper content type
      @view.controller.response.content_type = Mime::Type.lookup_by_extension(requested_format.to_s).to_s

      # Set proper caching headers
      if defined?(Rails) && Rails.env == 'production'
        @view.controller.response.headers['Cache-Control'] = 'public, max-age=86400'
      end

      # return rendered result
      return result.output_image(:format => requested_format)
    ensure

      # ensure garbage collection happens after every flex image render
      GC.start
    end
  end
end
