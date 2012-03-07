# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def form_title(name)
		div = '<div class="top"><div class="left"></div><div class="center1">&nbsp;' + name + '</div><div class="right"></div></div>'
		return div.html_safe
	end
end
