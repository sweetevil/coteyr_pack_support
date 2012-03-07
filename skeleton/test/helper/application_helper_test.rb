require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "form title content" do
		output = form_title "test"
		assert output.include?("test")
	end
end 