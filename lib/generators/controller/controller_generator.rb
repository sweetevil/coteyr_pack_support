class ControllerGenerator < Rails::Generators::NamedBase
  argument :actions, :type => :array, :default => [], :banner => "action action"
  check_class_collision :suffix => "Controller"
  attr_accessor :models_name, :model_name, :controller_name, :underscore_name

  def generate_layout
    ControllerGenerator.source_root(File.join(File.dirname(__FILE__), '../../templates/controller/'))
    @controller_name = "#{file_name.camelize}Controller"
    @underscore_name = file_name.underscore.downcase
    @models_name = file_name.downcase
    @model_name = file_name.singularize
    #directory('app/controllers')
    #directory('app/helpers')
    #directory('app/views')
    #directory(File.join('app/views',@underscore_name))
    template('index.rb', File.join('app/views',@underscore_name, '/index.html.erb'))
    template('new.rb', File.join('app/views',@underscore_name, '/new.html.erb'))
    template('edit.rb', File.join('app/views',@underscore_name, '/edit.html.erb'))
    template('show.rb', File.join('app/views',@underscore_name, '/show.html.erb'))
    template('_single.rb', File.join('app/views',@underscore_name, "_#{@underscore_name.singularize}.html.erb"))
    template('_form.rb', File.join('app/views',@underscore_name, '/_form.html.erb'))
    template('controller.rb',"app/controllers/#{@underscore_name}_controller.rb")
    template('helper.rb',"app/helpers/#{@underscore_name}_helper.rb")
    #route_resources @underscore_name
    #directory('test/functional')
    template('controller_test.rb',"test/functional/#{@underscore_name}_controller_test.rb")
    route "resources '#{file_name}'"
  end
end
