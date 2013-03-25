# Copyright (c) 2010 by Robert D. Cotey II
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

 ActionView::Base.default_form_builder = CoteyrFormBuilder
 FORM_SIZE = 'span6'
 FORM_OFFSET = 'offset3'

# this also contains overrides for default classes
module ActionView::Helpers::FormHelper
  def form_for(record, options = {}, &block)
    raise ArgumentError, "Missing block" unless block_given?
    size = options.delete(:size) if options[:size]
    offset = options.delete(:offset) if options[:offset]
    size ||= FORM_SIZE
    offset ||= FORM_OFFSET
    options[:html] ||= {}
    options[:html][:class] ||= 'form-horizontal ' + size + ' ' + offset
    case record
    when String, Symbol
      object_name = record
      object      = nil
    else
      object      = record.is_a?(Array) ? record.last : record
      object_name = options[:as] || ActiveModel::Naming.param_key(object)
      apply_form_for_options!(record, options)
    end

    options[:html][:remote] = options.delete(:remote) if options.has_key?(:remote)
    options[:html][:method] = options.delete(:method) if options.has_key?(:method)
    options[:html][:authenticity_token] = options.delete(:authenticity_token)

    builder = options[:parent_builder] = instantiate_builder(object_name, object, options, &block)
    output  = capture(builder, &block)
    default_options = builder.multipart? ? { :multipart => true } : {}
    to_return = '<div class="row-fluid">'
    to_return += form_tag(options.delete(:url) || {}, default_options.merge!(options.delete(:html))) { output }
    to_return += '</div>'
    to_return.html_safe
  end
end

module ActionView::Helpers::FormTagHelper
  def field_set_tag(legend = nil, options = {}, &block)
    content = capture(&block)
    to_return = '<fieldset><div class="well row-fluid block">'
    to_return += '<div class="navbar">'
    to_return += '<div class="navbar-inner"><h5>'
    to_return += legend if not legend.blank?
    to_return += '</h5></div></div>'
    to_return.concat(content)
    to_return += '</div></fieldset>'
    to_return.html_safe
  end
end
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
 html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
 # add nokogiri gem to Gemfile
 elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
 elements.each do |e|
  p e
   if e.node_name.eql? 'label'
     html = %(<div class="clearfix error">#{e}</div>).html_safe
   elsif e.node_name.eql? 'input'
     if instance.error_message.kind_of?(Array)
       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
     else
       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
     end
   end
 end
 html
end
