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
  module Helper
    
    # Creates an image tag that links directly to image data.  Recommended for displays of a
    # temporary upload that is not saved to a record in the databse yet.
    def embedded_image_tag(model, options = {})
      model.load_image
      format  = options[:format] || :jpg
      mime    = Mime::Type.lookup_by_extension(format.to_s).to_s
      image   = model.output_image(:format => format)
      data    = Base64.encode64(image)
      
      options = { :alt => model.class.to_s }.merge(options)
      
      result = image_tag("data:#{mime};base64,#{data}", options)
      result.gsub(%r{src=".*/images/data:}, 'src="data:')
      
    rescue Fleximage::Model::MasterImageNotFound => e
      nil
    end
    
    # Creates a link that opens an image for editing in Aviary.
    #
    # Options:
    # 
    # * image_url: url to the master image used by Aviary for editing.  Defauls to <tt>url_for(:action => 'aviary_image', :id => model, :only_path => false)</tt>
    # * post_url:  url where Aviary will post the updated image.  Defauls to <tt>url_for(:action => 'aviary_image_update', :id => model, :only_path => false)</tt>
    #
    # All other options are passed directly to the @link_to@ helper.
    def link_to_edit_in_aviary(text, model, options = {})
      key       = aviary_image_hash(model)
      image_url = options.delete(:image_url)        || url_for(:action => 'aviary_image',        :id => model, :only_path => false, :key => key)
      post_url  = options.delete(:image_update_url) || url_for(:action => 'aviary_image_update', :id => model, :only_path => false, :key => key)
      api_key   = Fleximage::AviaryController.api_key
      url       = "http://aviary.com/flash/aviary/index.aspx?tid=1&phoenix&apil=#{api_key}&loadurl=#{CGI.escape image_url}&posturl=#{CGI.escape post_url}"
      
      link_to text, url, { :target => 'aviary' }.merge(options)
    end
    
  end
end
