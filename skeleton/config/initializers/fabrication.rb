APPLICATION_NAME_HERE::Application.configure do
  config.generators do |g|
    g.test_framework      :test_unit, fixture_replacement: :fabrication
    g.fixture_replacement :fabrication, dir: "test/fabricators"
  end
end
