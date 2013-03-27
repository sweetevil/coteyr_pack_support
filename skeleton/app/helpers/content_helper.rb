module ContentHelper
  def well(title, options = {}, &block)
    uid = options[:id] if options[:id]
    uid ||= SecureRandom.uuid()
    size = "span3" if options[:size] and options[:size].to_i == 3
    size = "span4" if options[:size] and options[:size].to_i == 4
    size = "span6" if options[:size] and options[:size].to_i == 6
    size = "span8" if options[:size] and options[:size].to_i == 8
    size ||= "span12"
    offset = "offset3" if options[:offset] and options[:offset].to_i == 3
    offset = "offset4" if options[:offset] and options[:offset].to_i == 4
    offset = "offset6" if options[:offset] and options[:offset].to_i == 6
    offset = "offset8" if options[:offset] and options[:offset].to_i == 8
    offset ||= ""



    to_return = '<div class="' + size.to_s + " " + offset.to_s + '">'

    to_return += '<div class="block well">'
     to_return += '<div class="navbar"><div class="navbar-inner"><h5>' + title + "</h5>"
    if options[:collapse] then
        to_return += '<div class="nav pull-right">'
        to_return += '<a class="just-icon" data-toggle="collapse" data-target="#' + uid + '"><i class="font-resize-vertical"></i></a>'
        to_return += '</div>'
    end
    to_return += "</div>"
    to_return += '</div>'

    to_return += '<div class="collapse in" id="' + uid + '">' if options[:collapse]
    to_return += '<div class="'
    if not options[:pad] == false then
      to_return += 'body '
    end
    to_return += 'align-center' if options[:center]
    to_return += '" id="' + uid + '">'
    to_return += with_output_buffer(&block)
    to_return += '</div></div></div>'
    to_return += '</div>' if options[:collapse]
    to_return.to_s.html_safe
  end
  def row(&block)
    to_return = '<div class="row-fluid" >' + with_output_buffer(&block) + '</div>'
    to_return.to_s.html_safe
  end
  def seperator(options={type: 'doubled'})
    to_return = '<div class="separator"></div>' if options[:type] == "plain"
    to_return = '<div class="separator"><span></span></div>' if options[:type] == 'squared'
    to_return = '<div class="separator-reflected"></div>' if options[:type] == 'reflected'
    to_return = '<div class="separator-doubled"></div>' if options[:type] == 'doubled'
    to_return = '<div class="separator-dashed"></div>' if options[:type] == 'dashed'
    to_return = '<div class="separator-shadow"></div>' if options[:type] == 'shadow'
    to_return ||= '<div class="separator-doubled"></div>'
    to_return.to_s.html_safe
  end
  def button(body, url="", options={})
    if url.blank?
      to_return = '<button type="button" class="btn '
      if options[:icon] then
          body = '<i class="' + options[:icon] + '"></i>' + body
          body = body.html_safe
      end
      if options[:type]
          to_return += 'btn-' + options[:type]
      end
      if options[:block]
          to_return += ' btn-block '
      end
      to_return += '">' + body + '</button>'
    else
      options[:class] ||= ''
      options[:class] += ' btn '
      if options[:type]
        options[:class] += ' btn-' + options[:type] + ' '
      end
      if options[:block]
        options[:block] += ' btn-block '
      end
      to_return = link_to(body, url, options).html_safe
    end
    return to_return.html_safe
  end
  def button_group(&block)
    to_return = '<div class="btn-group" style="margin-top: 10px;">' + with_output_buffer(&block) +'</div>'
    to_return.html_safe
  end
  def syntax(&block)
    to_return = '<pre class="pre-scrollable prettyprint linenums">'
    to_return += with_output_buffer(&block)
    to_return +='</pre>'
    to_return.html_safe
  end
  def tabs(&block)
    ('<div class="tabbable">' + with_output_buffer(&block) + '</div>').html_safe
  end
  def tab_links(&block)
    ('<ul class="nav nav-tabs">' + with_output_buffer(&block) + '</ul>').html_safe
  end
  def tab_link(name, id, options={})
    to_return = '<li><a href="#' + id.to_s + '" data-toggle="tab">'
    if options[:icon] then
      to_return += '<i class="' + options[:icon] + '"></i>'
    end
    to_return += name
    to_return += '</a></li>'
    to_return.html_safe
    #tab1" data-toggle="tab">font-cog"></i>Visible</a></li>
  end
  def tab_content(&block)
    ('<div class="tab-content">' + with_output_buffer(&block) + '</div>').html_safe
  end
  def tab(id, options={}, &block)
    if options[:active] then
      ('<div class="tab-pane body active" id="' + id + '">' + with_output_buffer(&block) + '</div>').html_safe
    else
      ('<div class="tab-pane body" id="' + id + '">' + with_output_buffer(&block) + '</div>').html_safe
    end
  end
  def bar(label, options={})
    to_return = '<div class="control-group">'
    if not label.blank? then
      to_return += '<span class="control-label">' + label + '</span>'
    end
    to_return += '<div class="controls">'
    if options[:type] then
      type = options[:type]
    else
      type = 'info'
    end
    to_return += '<div class="progress progress-' + type+ ' '
    if options[:delay] then
       to_return += 'delay'
    elsif options[:part] and options[:total]
      to_return += 'value'
    elsif options[:slim]
      to_return += 'slim'
    end
    to_return += '">'
    if options[:part] and options[:total] then
      pct = (100 * (options[:part].to_f/options[:total].to_f)).to_i
      to_return += '<div class="bar" data-percentage="' + pct.to_s + '" data-amount-part="' + options[:part].to_s + '" data-amount-total="' + options[:total].to_s + '">'
    else
      to_return += '<div class="bar '
      if options[:label] then
        to_return += 'filled-text'
      else
        to_return += 'no-text'
      end
      to_return += '"'
      if options[:percentage] then
        to_return += ' data-percentage="' + options[:percentage].to_s + '">'
      end
    end
    to_return += '</div></div></div></div>'
    to_return.html_safe
  end
end
