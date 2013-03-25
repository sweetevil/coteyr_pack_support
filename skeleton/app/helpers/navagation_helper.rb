module NavagationHelper
  def nav_link_to(body, url, options={})
    to_return = "<li>"
    if options[:icon] then
      body = '<span class="' + options.delete(:icon) + '"></span>' + body
    end
    if options[:count] then
      body = body + "<strong>" + options.delete(:count).to_s + "</strong>"
    end
    body = body.html_safe
    to_return += link_to(body, url, options)
    to_return += "</li>"
    to_return.to_s.html_safe
  end
  def page_icon_link_to(body, url, options={})
# <li><a href="#" title="My tasks"><i class="font-tasks"></i><span>Tasks</span></a></li>
    to_return = "<li>"
    body = '<span>' + body + '</span>'
    if options[:icon] then
      body = '<i class="' + options.delete(:icon) + '"></i>' + body
    end
    body = body.html_safe
    to_return += link_to(body, url, options)
    to_return += "</li>"
    to_return.to_s.html_safe
  end
  def mid_icon_link_to(body, url, options)
    # <li><a href="#" title="Add something"><img src="images/icons/color/hire-me.png" alt="" /><span>Add users</span></a><strong>4</strong></li>
    to_return = "<li>"
    body = '<span>' + body + '</span>'
    body = body.html_safe
    body = image_tag(options.delete(:icon)) + body
    to_return += link_to(body, url, options)
    if options[:count] then
      to_return += '<strong>' + options.delete(:count).to_s + '</strong>'
    end
    to_return += '</li>'
    to_return.to_s.html_safe

  end
end
