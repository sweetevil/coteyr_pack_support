require 'rspec/core/rake_task'
desc "Task to do some preparations for CruiseControl"
task :prepare do
  RAILS_ENV = 'test'
end

desc "Task for CruiseControl.rb"
task :cruise do
  RAILS_ENV = 'test'
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:schema:load'].invoke
  Rake::Task['run_all'].prerequisites.clear
  Rake::Task['run_all'].invoke()
  if out = ENV['CC_BUILD_ARTIFACTS']
    spec_out = "#{out}/coverage"
    mkdir_p spec_out unless File.directory? spec_out
    if ! spec_out.blank?
      sh "cp -r #{Rails.root.to_s}/coverage/* #{spec_out}"
      sh "cp #{Rails.root.to_s}/coverage/docs.html #{ENV['CC_BUILD_ARTIFACTS']}/"
    end
  end
end
RSpec::Core::RakeTask.new(:run_all) do |t|
  t.rspec_opts = "-O .rspec.ci"
end
