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
#    along with coteyr_pack.  If not, see <http://www.gnu.org/licenses/>.module Fleximage
  module Operator
        
    # Resize this image, constraining proportions.  Options allow cropping, stretching, upsampling and
    # padding.
    # 
    #   image.resize(size, options = {})
    # 
    # +size+ is size of the output image after the resize operation.  Accepts either <tt>'123x456'</tt>
    # format or <tt>[123, 456]</tt> format.
    #
    # Use the following keys in the +options+ hash:
    #   
    # * +crop+: pass true to this option to make the ouput image exactly 
    #   the same dimensions as +size+.  The default behaviour will resize the image without
    #   cropping any part meaning the image will be no bigger than the +size+.  When <tt>:crop</tt>
    #   is true the final image is resized to fit as much as possible in the frame, and then crops it 
    #   to make it exactly the dimensions declared by the +size+ argument.
    #  
    # * +upsample+: By default the image will never display larger than its original dimensions, 
    #   no matter how large the +size+ argument is.  Pass +true+ to use this option to allow
    #   upsampling, disabling the default behaviour.
    #
    # * +padding+: This option will pad the space around your image with a solid color to make it exactly the requested
    #   size.  Pass +true+, for the default of +white+, or give it a text or pixel color like <tt>"red"</tt> or 
    #   <tt>color(255, 127, 0)</tt>.  This is like the opposite of the +crop+ option.  Instead of trimming the 
    #   image to make it exactly the requested size, it will make sure the entire image is visible, but adds space 
    #   around the edges to make it the right dimensions.
    #
    # * +stretch+: Set this option to true and the image will not preserve its aspect ratio.  The final image will
    #   stretch to fit the requested +size+.  The resulting image is exactly the size you ask for.
    # 
    # Example:
    # 
    #   @photo.operate do |image|
    #     image.resize '200x200', :crop => true
    #   end
    class Resize < Operator::Base
      def operate(size, options = {})
        options = options.symbolize_keys
        
        # Find dimensions
        x, y = size_to_xy(size)

        # prevent upscaling unless :usample param exists.
        unless options[:upsample]
          x = @image.columns if x > @image.columns
          y = @image.rows    if y > @image.rows
        end

        # Perform image resize
        case
        when options[:crop] && !options[:crop].is_a?(Hash) && @image.respond_to?(:crop_resized!)
          # perform resize and crop
          scale_and_crop([x, y])

        when options[:stretch]
          # stretch the image, ignoring aspect ratio
          stretch([x, y])

        else
          # perform the resize without crop
          scale([x, y])

        end

        # apply padding if necesary
        if padding_color = options[:padding]
          # get color
          padding_color = 'white' if padding_color == true

          # get original x and y.  This makes it play nice if the requested size is larger 
          # than the image and upsampling is not allowed.
          x, y = size_to_xy(size)

          # get proper border sizes
          x_border = [0, (x - @image.columns + 1) / 2].max
          y_border = [0, (y - @image.rows    + 1) / 2].max

          # apply padding
          @image.border!(x_border, y_border, padding_color)

          # crop to remove possible extra pixel
          @image.crop!(0, 0, x, y, true)
        end
        
        return @image
      end
    end
    
  end
end