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

