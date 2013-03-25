<% # Copyright (c) 2010 by Robert D. Cotey II
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
-%>

<%%= render "layouts/error_messages", target: @<%= underscore_name.singularize %> %>
<%= "\<\%\= form_for @#{underscore_name.singularize} do |f| \%\>" %>
  <%= "\<\%\= field_set_tag '#{underscore_name.singularize}' do \%\>" %>
    <%= "\<\%\= f.form_actions \%\>"
  <%= "\<\% end \%\>" %>
<%= "\<\% end \%\>" %>
