# Copyright (c) 2010 Copyright (c) 2017 Muhammad Yawar Ali D. Cotey II
# Orignal version from http://github.com/rubypond/semantic_form_builder/tree (released under MIT Licence 2008)
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
module SemanticFormHelper

  def wrapping(type, field_name, label, field, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = ""
    to_return << %Q{<div class="#{type}-field #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>} unless ["radio","check", "submit"].include?(type)
    to_return << %Q{<div class="input">}
    to_return << field
    to_return << %Q{<label for="#{field_name}">#{label}</label>} if ["radio","check"].include?(type)
    to_return << %Q{</div></div>}
    to_return.to_s.html_safe
  end

  def semantic_group(type, field_name, label, fields, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = ""
    to_return << %Q{<div class="#{type}-fields #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>}
    to_return << %Q{<div class="input">}
    to_return << fields.join
    to_return << %Q{</div></div>}
    to_return.to_s.html_safe
  end

  def boolean_field_wrapper(input, name, value, text, help = nil)
    field = ""
    field << %Q{<label>#{input} #{text}</label>}
    field << %Q{<div class="help">#{help}</div>} if help
    field.to_s.html_safe
  end

  def check_box_tag_group(name, values, options = {})
    selections = ""
    values.each do |item|
      if item.is_a?(Hash)
        value = item[:value]
        text = item[:label]
        help = item.delete(:help)
      else
        value = item
        text = item
      end
      box = check_box_tag(name, value)
      selections << boolean_field_wrapper(box, name, value, text)
    end
    label = options[:label]
    semantic_group("check-box", name, label, selections, options)
  end

end
