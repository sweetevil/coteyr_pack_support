<%= "\<\%\= error_messages_for '#{model_name}' \%\>" %>
<%= "\<\% form_for @#{model_name} do |f| \%\>" %>
    <%= "\<\% field_set_tag '#{model_name}' do \%\>" %>
    <%= "\<\%\= f.submit 'Save' \%\>" %>
  <%= "\<\% end \%\>" %>
<%= "\<\% end \%\>" %>