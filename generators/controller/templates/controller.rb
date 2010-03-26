class <%= controller_name %> < ApplicationController
  include Restful
  def initialize
    @skope = "<%= model_name.camelize %>"
    @klass =  <%= model_name.camelize %>
  end
end