# Copyright (c) 2010 by Robert D. Cotey II
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

#Basic Skelton Deployment file. Look in the deploy=settings and deploy-custom for actual configuration.
require 'bundler/capistrano'
set :stages, %w(production staging)
set :default_stage, "production"
set :git_enable_submodules, true
require 'config/deploy-settings.rb'
require 'config/deploy-custom.rb'
require 'capistrano/ext/multistage'
default_run_options[:pty] = true
set :scm, "git"
ssh_options[:forward_agent] = true
#Paths

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
 namespace :deploy do
   task :start do
   end
   task :stop do
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{current_path}/tmp/restart.txt"
   end
 end
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


#after :deploy, "passenger:restart"

