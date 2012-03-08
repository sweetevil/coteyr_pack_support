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
    
    # Sharpen an image using an unsharp mask filter.
    # 
    #   image.unsharp_mask(options = {})
    #
    # Use the following keys in the +options+ hash:
    #
    # * +radius+: The radius of the Gaussian operator. The default is 0.0.
    # * +sigma+: The standard deviation of the Gaussian operator. A good starting value is 1.0, which is the default.
    # * +amount+: The percentage of the blurred image to be added to the receiver, specified as a fraction between 0 and 1.0. A good starting value is 1.0, which is the default.
    # * +threshold+: The threshold needed to apply the amount, specified as a fraction between 0 and 1.0. A good starting value is 0.05, which is the default.
    #
    # Example:
    #
    #   @photo.operate do |image|
    #     image.unsharp_mask
    #   end
    class UnsharpMask < Operator::Base
      def operate(options = {})
        options = options.symbolize_keys if options.respond_to?(:symbolize_keys)
        options = {
          :radius    => 0.0,
          :sigma     => 1.0,
          :amount    => 1.0,
          :threshold => 0.05
        }.merge(options)

        # sharpen image
        @image = @image.unsharp_mask(options[:radius], options[:sigma], options[:amount], options[:threshold])
      end
    end
    
  end
end