require 'pp'

# Copyright (c) 2010 Robert D. Cotey II
# Copyright (c) 2005 Jamis Buck (git commit e8b603e523c14f145da7b3a1729f5cc06eba2dd1)
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
module ExceptionNotifierHelper
  VIEW_PATH = "views/exception_notifier"
  APP_PATH = "#{RAILS_ROOT}/app/#{VIEW_PATH}"
  PARAM_FILTER_REPLACEMENT = "[FILTERED]"

  def render_section(section)
    RAILS_DEFAULT_LOGGER.info("rendering section #{section.inspect}")
    summary = render_overridable(section).strip
    unless summary.blank?
      title = render_overridable(:title, :locals => { :title => section }).strip
      "#{title}\n\n#{summary.gsub(/^/, "  ")}\n\n"
    end
  end

  def render_overridable(partial, options={})
    if File.exist?(path = "#{APP_PATH}/_#{partial}.rhtml")
      render(options.merge(:file => path, :use_full_path => false))
    elsif File.exist?(path = "#{File.dirname(__FILE__)}/../#{VIEW_PATH}/_#{partial}.rhtml")
      render(options.merge(:file => path, :use_full_path => false))
    else
      ""
    end
  end

  def inspect_model_object(model, locals={})
    render_overridable(:inspect_model,
      :locals => { :inspect_model => model,
                   :show_instance_variables => true,
                   :show_attributes => true }.merge(locals))
  end

  def inspect_value(value)
    len = 512
    result = object_to_yaml(value).gsub(/\n/, "\n  ").strip
    result = result[0,len] + "... (#{result.length-len} bytes more)" if result.length > len+20
    result
  end

  def object_to_yaml(object)
    object.to_yaml.sub(/^---\s*/m, "")
  end

  def exclude_raw_post_parameters?
    @controller && @controller.respond_to?(:filter_parameters)
  end

  def filter_sensitive_post_data_parameters(parameters)
    exclude_raw_post_parameters? ? @controller.__send__(:filter_parameters, parameters) : parameters
  end

  def filter_sensitive_post_data_from_env(env_key, env_value)
    return env_value unless exclude_raw_post_parameters?
    return PARAM_FILTER_REPLACEMENT if (env_key =~ /RAW_POST_DATA/i)
    return @controller.__send__(:filter_parameters, {env_key => env_value}).values[0]
  end
end
