#Basic Skelton Deployment file. Look in the deploy=settings and deploy-custom for actual configuration.
set :stages, %w(production testing)
set :default_stage, "testing"
set :git_enable_submodules, true
require 'config/deploy-settings.rb'
require 'config/deploy-custom.rb'
require 'capistrano/ext/multistage'
default_run_options[:pty] = true
set :scm, "git"
ssh_options[:forward_agent] = true
#Paths
set(:deploy_to) {"/home/#{user}/web/#{application}-code"}
set(:public_path) {"/home/#{user}/web/#{domain}"}
#Servers
server domain, :app, :web
role :db, domain, :primary => true
role :task_server, domain
#Passenger
namespace :passenger do
    desc "Restart Application"
    task :restart do
        run "touch #{current_path}/tmp/restart.txt"
    end
    desc "Create Symlink for Passenger"
    task :linkin do
        run "rm -rf #{public_path}"
        run "ln -s #{current_path}/public #{public_path}"
    end
end


after :deploy, "passenger:restart"


