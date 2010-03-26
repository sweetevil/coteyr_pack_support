class ControllerGenerator < Rails::Generator::NamedBase
  attr_accessor :models_name, :model_name, :controller_name
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      @controller_name = "#{@class_name}Controller"
      @models_name = @class_name.downcase
      @model_name = @models_name.singularize
      m.directory('app/controllers')
      m.directory('app/helpers')
      m.directory(File.join('app/views',@models_name))
      m.template('index.rb', File.join('app/views',@models_name, '/index.html.erb'))
      m.template('new.rb', File.join('app/views',@models_name, '/new.html.erb'))
      m.template('edit.rb', File.join('app/views',@models_name, '/edit.html.erb'))
      m.template('show.rb', File.join('app/views',@models_name, '/show.html.erb'))
      m.template('_single.rb', File.join('app/views',@models_name, "_#{model_name}.html.erb"))
      m.template('_form.rb', File.join('app/views',@models_name, '/_form.html.erb'))
      m.template('controller.rb',"app/controllers/#{@models_name}_controller.rb")
      m.template('helper.rb',"app/helpers/#{models_name}_helper.rb")
      m.route_resources @models_name
      m.directory('test/functional')
      m.template('controller_test.rb',"test/functional/#{models_name}_controller_test.rb")
    end
  end
end
