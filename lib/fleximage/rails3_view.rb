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
  class Rails3View

    class TemplateDidNotReturnImage < RuntimeError #:nodoc:
    end

    def self.call(template)
      self.new.compile(template)
    end

    def compile(template)
      <<-CODE
      @template_format = :flexi
      controller.response.content_type ||= Mime::JPG
      result = #{template.source}
      requested_format = (params[:format] || :jpg).to_sym
      begin
        # Raise an error if object returned from template is not an image record
        unless result.class.include?(Fleximage::Model::InstanceMethods)
          raise TemplateDidNotReturnImage, ".flexi template was expected to return a model instance that acts_as_fleximage, but got an instance of instead."
        end
        # Figure out the proper format
        raise 'Image must be requested with an image type format.  jpg, gif and png only are supported.' unless [:jpg, :gif, :png].include?(requested_format)
        result.output_image(format: requested_format)
      rescue Exception => e
        e
      end
      CODE
    ensure
      GC.start
    end

  end
end
