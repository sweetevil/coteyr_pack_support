module NoticeHelper
  def notice(message, kind="", options={})
    to_return = '<div class="notice '
    if options[:closing] then
      to_return += "closing"
    end
    to_return += '" style="margin-bottom:2px;">'
    to_return += '<div class="note '
    if not kind.blank? then
      to_return += " note-#{kind}"
    end
    to_return += '"><button type="button" class="close">x</button>'
    to_return += message
    to_return += '</div></div>'
    to_return.to_s.html_safe
  end
end

