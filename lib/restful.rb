module Restful
    def index
        objs = eval(@skope).find(:all)
        instance_variable_set("@#{@klass.name.underscore.downcase.pluralize}", objs)
        respond_to do |format|
            format.html
            format.xml {render :xml=>objs.to_xml}
        end
    end
    def new
        obj = @klass.new
        instance_variable_set("@#{@klass.name.underscore.downcase}", obj) if !instance_variable_get("@#{@klass.name.underscore.downcase}")
        respond_to do |format|
            format.html
            format.xml {render :xml=>obj.to_xml}
            format.js {}
        end
    end
    def create
        obj = @klass.new
        worked = obj.update_attributes params["#{@klass.name.underscore.downcase}".to_sym]
        instance_variable_set("@#{@klass.name.underscore.downcase}", obj)
        respond_to do |format|
            format.html {
              if worked
                redirect_to :action=>:index
              else
                render :action=>:new
              end
            }

            format.xml {render :xml=>obj, :status => :created, :location=>obj}
            format.js {
              if worked
                objs = eval(@skope).find(:all)
                instance_variable_set("@#{@klass.name.underscore.downcase.pluralize}", objs)
              else
                render :action=>:new
              end
            }
        end
    end
    def show
        obj = @klass.find params[:id]
        instance_variable_set("@#{@klass.name.underscore.downcase}", obj)
        respond_to do |format|
            format.html
            format.xml {render :xml=>obj.to_xml}
        end
    end
    def update
        obj = @klass.find params[:id]
        worked = obj.update_attributes params["#{@klass.name.underscore.downcase}".to_sym]
        respond_to do |format|
            format.html{
              if worked
                redirect_to :action=>:index
              else
                session[:temp] = obj
                redirect_to edit_polymorphic_path(obj)
              end
            }
            format.xml{render :xml=>obj, :status => :updated, :location=>obj}
            format.json {
              if worked
                render :json=>obj
              else
                render :json=>obj, :status=>500
              end
            }
        end
    end
    def destroy
        obj = @klass.find params[:id]
        obj.destroy
        respond_to do |format|
            format.html {redirect_to :action=>:index}
            format.xml {head :ok}
        end
    end
    def edit
      if session[:temp]
        obj = session[:temp]
        session[:temp] = nil
      else
        obj = @klass.find params[:id]
      end
        instance_variable_set("@#{@klass.name.underscore.downcase}", obj) if !instance_variable_get("@#{@klass.name.underscore.downcase}")
        respond_to do |format|
            format.html
            format.xml {render :xml=>obj.to_xml}
        end
    end
    def create_or_edit(cls, param, redirect=nil)
        obj = cls.new
        obj = cls.find(params[:id]) if !params[:id].nil?
        if request.post?
            if obj.update_attributes params[param]
                redirect_to redirect if !redirect.nil?
            end
        end
        obj
    end
    def create_or_edit_with_values(cls, param, fields)
        obj = create_or_edit(cls, param)
        for field in fields.keys
            obj[field.to_sym] = fields[field.to_sym]
        end
        obj.errors.clear
        obj.save
        obj
    end
end