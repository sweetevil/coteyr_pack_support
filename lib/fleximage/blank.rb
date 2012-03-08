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
  
  # The +Blank+ class allows easy creation of dynamic images for views which depends models that
  # do not store images.  For example, perhaps you want a rendering of a text label, or a comment,
  # or some other type of data that is not inherently image based.
  #
  # Your model doesn't need to know anything about Fleximage.  You can instantiate and operate on
  # a new Fleximage::Blank object right in your view.
  #
  # Usage:
  # 
  #   Fleximage::Blank.new(size, options = {}).operate { |image| ... }
  #
  # Use the following keys in the +options+ hash:
  #
  # * color: the color the image will be.  Can be a named color or a Magick::Pixel object.
  #   
  # Example:
  #
  #   # app/views/comments/show.png.flexi
  #   Fleximage::Blank.new('400x150')).operate do |image|
  #     # Start with a chat bubble image as the background
  #     image.image_overlay('public/images/comment_bubble.png')
  #     
  #     # Assuming that the user model acts_as_fleximage, this will draw the users image.
  #     image.image_overlay(@comment.user.file_path,
  #       :size => '50x50',
  #       :alignment => :top_left,
  #       :offset => '10x10'
  #     )
  #     
  #     # Add the author name text
  #     image.text(@comment.author,
  #       :alignment => :top_left,
  #       :offset => '10x10',
  #       :color => 'black',
  #       :font_size => 24,
  #       :shadow => {
  #         :blur => 1,
  #         :opacity => 0.5,
  #       }
  #     )
  #     
  #     # Add the comment body text
  #     image.text(@comment.body, 
  #       :alignment => :top_left,
  #       :offset => '10x90',
  #       :color => color(128, 128, 128),
  #       :font_size => 14
  #     )
  #   end
  class Blank
    include Fleximage::Model
    acts_as_fleximage
    
    def initialize(size, options = {})
      width, height = Fleximage::Operator::Base.size_to_xy(size)
      
      @uploaded_image = Magick::Image.new(width, height) do
        self.colorspace = Magick::RGBColorspace
        self.depth      = 8
        self.density    = '72'
        self.format     = 'PNG'
        self.background_color = options[:color] || 'none'
      end
      
      @output_image = @uploaded_image
    end
  end
end