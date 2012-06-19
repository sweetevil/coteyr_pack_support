APPLICATION_NAME_HERE::Application.configure do
  config.generators do |g|
    g.test_framework      :rspec, fixture: true
    g.fixture_replacement :fabrication
  end
end
