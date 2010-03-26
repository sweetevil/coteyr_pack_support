#custom tasks and such for deployment
Capistrano::Configuration.instance(:must_exist).load do
#  namespace :sample do
#      desc "Sample Task"
#      task :tasker do
#          run "echo hellow world"
#      end
#  end
#  after :deploy, "sample:tasker"

end
