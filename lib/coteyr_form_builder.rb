class CoteyrFormBuilder < ActionView::Helpers::FormBuilder
  include CoteyrFormHelper
  def field_settings(method, options = {}, noClass=false)
    options[:class] ||= 'span12' if not noClass
    if options[:focus_tip] then
        options[:class] += ' focustip '
        options[:title] ||= options.delete(:focus_tip)
    end
    if options[:hover_tip] then
        options[:class] += ' hovertip '
        options[:title] ||= options.delete(:hover_tip)
    end
    field_name = "#{@object_name}_#{method.to_s}"
    default_label = "#{method.to_s.gsub(/\_/, " ")}"
    label = options[:label] ? options.delete(:label) : default_label
    options[:class] ||= ""
    options[:class] += options[:required] ? " required" : ""
    label += "<strong><sup>*</sup></strong>" if options[:required]
    [field_name, label, options]
  end
  def text_field(method, options = {})
    field_name, label, options = field_settings(method, options)
    wrapping("text", field_name, label, super, options)
  end
  def password_field(method, options={})
    field_name, label, options = field_settings(method, options)
    wrapping("password", field_name, label, super, options)
  end
  def text_area(method, options={})
    field_name, label, options = field_settings(method, options)
    options[:class] += ' auto '
    wrapping("text_area", field_name, label, super, options)
  end
  def date_field(method, options={})
    options[:class] ||= 'span12'
    options[:class] += ' datepicker'
    text_field(method, options)
  end
  def select(method, choices, options = {}, html_options = {})
    field_name, label, options = field_settings(method, options)
    if options[:search] then
      html_options[:class] ||= 'select'
      html_options['data-placeholder'] = label
    else
      html_options[:class] ||= 'span12'
      html_options[:class] += ' style '
    end
    wrapping("select", field_name, label, super, options)
  end
  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    field_name, label, options = field_settings(method, options, true)
    options[:class] += 'style'
    wrapping("check-box", field_name, label, super, options)
  end
  def form_actions(submit_value="Save", reset_value="Clear")
    to_return = '<div class="form-actions align-right">'
    to_return += @template.button_tag(submit_value, class: 'btn btn-primary', disable_with: "Please wait...", type: 'submit')
    to_return += ' '
    to_return += @template.button_tag(reset_value, class: 'btn btn-danger', type: 'reset')
    to_return += '</div>'
    to_return.html_safe
  end
  def file_field(method, options = {})
    field_name, label, options = field_settings(method, options)
    options[:class] += ' style'
    wrapping("password", field_name, label, super, options)
  end
  def radio_button_group(method, vaules, options={})
    for value in values
      if value.is_a?(Hash)
        value_text = value[:label]
        tag_value = value[:value]
      else
        value_text = value
        tag_value = 1
      end
      to_return = '<label class="radio inline">'
      to_return += value
      to_return += @template.radio_button(@object_name, method, tag_value, options.merge(object: @object, class: 'style'))
      to_return += "</label>"

    end
    field_name, label, options = field_settings(method, options)
    wrapping("radio_group", field_name, label, to_return, options)
  end





end
