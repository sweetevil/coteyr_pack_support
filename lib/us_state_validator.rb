class UsStateValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    unless ['AK', 'AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT','VA','VT','WA', 'WI', 'WV', 'WY'].include? value
      object.errors[attribute] << (options[:message] || "is not a valid US State")  
    end  
  end  
end  