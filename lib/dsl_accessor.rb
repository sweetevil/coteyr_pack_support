# Copyright (c) 2017 Muhammad Yawar Ali
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

require 'active_support' unless defined?(ActiveSupport)

class Class
  def dsl_accessor(name, options = {})
    raise TypeError, "DSL Error: options should be a hash. but got `#{options.class}'" unless options.is_a?(Hash)
    writer = options[:writer] || options[:setter]
    writer =
      case writer
      when NilClass then Proc.new{|value| value}
      when Symbol   then Proc.new{|value| __send__(writer, value)}
      when Proc     then writer
      else raise TypeError, "DSL Error: writer should be a symbol or proc. but got `#{options[:writer].class}'"
      end
    class_attribute :"#{name}_writer"
    class_attribute :"#{name}_value"
    self.send(:"#{name}_writer=", writer)

    default =
      case options[:default]
      when NilClass then nil
      when []       then Proc.new{[]}
      when {}       then Proc.new{{}}
      when Symbol   then Proc.new{__send__(options[:default])}
      when Proc     then options[:default]
      else Proc.new{options[:default]}
      end
    class_attribute :"#{name}_default"
    self.send(:"#{name}_default=", default)

    self.class.class_eval do
      define_method("#{name}=") do |value|
        writer = self.send(:"#{name}_writer")
        value  = writer.call(value) if writer
        self.send(:"#{name}_value=", value)
      end

      define_method(name) do |*values|
        if values.empty?
          # getter method
          key = :"#{name}"
          if !self.respond_to?(key)
            default = self.send(:"#{name}_default")
            value   = default ? default.call(self) : nil
            self.send("#{name}_value=", value)
          end
          self.send("#{key}_value")
        else
          # setter method
          __send__("#{name}_value=", *values)
        end
      end
    end
  end
end

