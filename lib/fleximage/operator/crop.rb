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
  module Operator
    
    # Crops the image without doing any resizing first.  The operation crops from the :+from+ coordinate,
    # and returns an image of size :+size+ down and right from there.
    # 
    #   image.crop(options = {})
    #
    # Use the following keys in the +options+ hash:
    #
    # * +gravity+: Select gravity for the crop. Default is :top_left (Magick::NorthWestGravity)
    #   Choose from GRAVITITES constant defined in base.rb.
    # * +from+: coorinates for the upper left corner of resulting image.
    # * +size+: The size of the resulting image, going down and to the right of the :+from+ coordinate.
    # 
    #  size and from options are *required*.
    #
    # Example:
    #
    #   @photo.operate do |image|
    #     image.crop(
    #       :from => '100x50',
    #       :size => '500x350'
    #     )
    #   end
    #
    # or
    #
    #   @photo.operate do |image|
    #     image.crop(
    #       :gravity => :center,
    #       :from    => '100x50',
    #       :size    => '500x350'
    #     )
    #   end
    class Crop < Operator::Base
      def operate(options = {})
        options = options.symbolize_keys
        options.reverse_merge!(:gravity => :top_left)

        # required integer keys
        [:from, :size].each do |key|
          raise ArgumentError, ":#{key} must be included in crop options" unless options[key]
          options[key] = size_to_xy(options[key])
        end

        # width and height must not be zero
        options[:size].each do |dimension|
          raise ArgumentError, ":size must not be zero for X or Y" if dimension.zero?
        end

        # crop
        @image.crop!(symbol_to_gravity(options[:gravity]), options[:from][0], options[:from][1], options[:size][0], options[:size][1], true)
      end
    end
    
  end
end