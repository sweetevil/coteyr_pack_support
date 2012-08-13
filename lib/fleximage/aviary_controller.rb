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

  module AviaryController
    def self.api_key(value = nil)
      value ? @api_key = value : @api_key
    end

    def self.api_key=(value = nil)
      api_key value
    end

    # Include acts_as_fleximage class method
    def self.included(base) #:nodoc:
      base.extend(ClassMethods)
    end

    module ClassMethods

      # Invoke this method to enable this controller to allow editing of images via Aviary
      def editable_in_aviary(model_class, options = {})
        unless options.has_key?(:secret)
          raise ArgumentError, ":secret key in options is required.\nExample: editable_in_aviary(Photo, secret: \"My-deep-dark-secret\")"
        end

        # Don't verify authenticity for aviary callback
        protect_from_forgery except: :aviary_image_update

        # Include the necesary instance methods
        include Fleximage::AviaryController::InstanceMethods

        # Add before_filter to secure aviary actions
        before_filter :aviary_image_security, only: [:aviary_image, :aviary_image_update]

        # Allow the view access to the image hash generation method
        helper_method :aviary_image_hash

        # Save the Fleximage model class
        model_class = model_class.constantize if model_class.is_a?(String)
        dsl_accessor :aviary_model_class, default: model_class
        dsl_accessor :aviary_secret, default: options[:secret]
      end

    end

    module InstanceMethods

      # Deliver the master image to aviary
      def aviary_image
        render text: @model.load_image.to_blob,
               content_type: Mime::Type.lookup_by_extension(self.class.aviary_model_class.image_storage_format.to_s)
      end

      # Aviary posts the edited image back to the controller here
      def aviary_image_update
        @model.image_file_url = params[:imageurl]
        @model.save
        render text: 'Image Updated From Aviary'
      end

      protected
        def aviary_image_hash(model)
          Digest::SHA1.hexdigest("fleximage-aviary-#{model.id}-#{model.created_at}-#{self.class.aviary_secret}")
        end

        def aviary_image_security
          @model = self.class.aviary_model_class.find(params[:id])
          unless aviary_image_hash(@model) == params[:key]
            render text: '<h1>403 Not Authorized</h1>', status: '403'
          end
        end

    end
  end

end
