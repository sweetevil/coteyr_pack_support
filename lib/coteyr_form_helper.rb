module CoteyrFormHelper

  def wrapping(type, field_name, label, field, options = {})
    to_return = '<div class="control-group">'
    to_return += '<label class="control-label">'
    if options[:icon] then
        to_return += '<i class="' + options.delete(:icon) + '"></i>'
    end
    to_return += label
    to_return += '</label>'

    if type == 'check-box' then
        if options[:on_off] then
            to_return += '<div class="controls on_off">'
            to_return += '<div class="checkbox inline">'
            to_return += field
            to_return += '<label class="toggle-label">' + label + '</label>'
            to_return += '</div>'
        else
            to_return += '<div class="controls">'
            to_return += '<label class="checkbox inline">' + field + label + '</label>'
        end
    else
        to_return += '<div class="controls">'
        to_return += field
    end
    if options[:field_icon] then
        to_return += '<i class="' + options.delete(:field_icon) +' field-icon"></i>'
    end
    if options[:help]
        to_return += '<span class="help-block">' + options.delete(:help) + '</span>'
    end
    to_return += '</div></div>'
    to_return.to_s.html_safe
  end
end
