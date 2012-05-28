APPLICATION_NAME_HERE::Application.configure do
  config.logger = Logger.new(Rails.root.join("log",Rails.env + ".log"),3,20*1024*1024)
end