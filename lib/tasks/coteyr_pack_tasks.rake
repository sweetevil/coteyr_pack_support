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


namespace :coteyr_pack do
  desc "Use this task to install coteyr_pack. Be advised files will be overwritten"
  task :setup do
    plugin_dir = File.join(File.dirname(__FILE__), '..')
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'public')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'test')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'config')], File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, '..', '.gitignore'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, '..', '.metrics'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, '..', 'Capfile'), File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'script')], File.join(Rails.root), :verbose => true)
    puts "Finished."
  end
  desc "Copy Application.html.erb and other first time files"
  task :first_time do
    plugin_dir = File.join(File.dirname(__FILE__), '..')
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'app')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'app')], File.join(Rails.root), :verbose => true)
    FileUtils.cp(File.join(plugin_dir, '..', 'Gemfile'),  ::Rails.root.to_s, :verbose=>true)
  end
  namespace :mac do
    desc "This starts the Ease of use Menu"
    task :menu do
      sh ( "#{::Rails.root.to_s}/script/menu_mac.sh '#{::Rails.root.to_s}'")
    end
    desc "Commits using ~/.bin/commit"
    task :commit do
      sh ("~/.bin/commit")
    end
    desc "Update local Repo using ~/.bin/pull"
    task :pull do
      sh ("~/.bin/pull")
    end
    desc "Run All tests"
    task :test_all do
      sh ("rake test")
    end
    desc "Run Autotest"
    task :auto_test do
      sh ("xterm -T Testing -e \"cd #{::Rails.root.to_s}; autotest\"")
    end
    desc "Run the console"
    task :console do
      sh ("xterm -T Console -e \"cd #{::Rails.root.to_s}; script/console \"")
    end
    desc "Run the Controller Generator (not script/generate but the wrapper)"
    task :controller do
      sh ("#{::Rails.root.to_s}/script/controller_mac.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the Migration Generator (not script/generate but the wrapper)"
    task :migration do
      sh ("#{::Rails.root.to_s}/script/mig_mac.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the Model Generator (not script/generate but the wrapper)"
    task :model do
      sh ("#{::Rails.root.to_s}/script/model_mac.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the DB Migrator (not rake db:migrate but the wrapper)"
    task :migrate do
      sh ("#{::Rails.root.to_s}/script/dbmig_mac.sh '#{::Rails.root.to_s}'")
    end
    desc "View Logs"
    task :log do
      sh ("konsole -workdir #{::Rails.root.to_s}  -e tail -n 100 -f '#{::Rails.root.to_s}/log/development.log'")
    end
    desc "Start the dev server"
    task :server do
      sh("xterm -e  \"cd #{::Rails.root.to_s}; script/server;sleep 20\" &")
    end
  end
  namespace :linux do
    desc "This starts the Ease of use Menu"
    task :menu do
      sh ( "#{::Rails.root.to_s}/script/menu.sh '#{::Rails.root.to_s}'")
    end
    desc "Commits using ~/.bin/commit"
    task :commit do
      sh ("~/.bin/commit")
    end
    desc "Update local Repo using ~/.bin/pull"
    task :pull do
      sh ("~/.bin/pull")
    end
    desc "Run All tests"
    task :test_all do
      sh ("konsole --noclose --workdir #{::Rails.root.to_s} -e rake test")
    end
    desc "Run Autotest"
    task :auto_test do
      sh ("konsole -workdir #{::Rails.root.to_s}  -e autotest")
    end
    desc "Run the console"
    task :console do
      sh ("konsole -workdir #{::Rails.root.to_s} -e script/console")
    end
    desc "Run the Controller Generator (not script/generate but the wrapper)"
    task :controller do
      sh ("#{::Rails.root.to_s}/script/controller.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the Migration Generator (not script/generate but the wrapper)"
    task :migration do
      sh ("#{::Rails.root.to_s}/script/mig.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the Model Generator (not script/generate but the wrapper)"
    task :model do
      sh ("#{::Rails.root.to_s}/script/model.sh '#{::Rails.root.to_s}'")
    end
    desc "Run the DB Migrator (not rake db:migrate but the wrapper)"
    task :migrate do
      sh ("#{::Rails.root.to_s}/script/dbmig.sh '#{::Rails.root.to_s}'")
    end
    desc "View Logs"
    task :log do
      sh ("konsole -workdir #{::Rails.root.to_s}  -e tail -n 100 -f '#{::Rails.root.to_s}/log/development.log'")
    end
    desc "Start the dev server"
    task :server do
      sh("konsole -workdir #{::Rails.root.to_s} -e script/server")
    end
  end
  namespace :log do
    desc "Statitcs"
    task :stats do
      sh("ruby #{::Rails.root.to_s}/vendor/plugins/coteyr_pack/lib/rails_log_parser.rb #{::Rails.root.to_s}/log/#{RAILS_ENV}.log")
    end
  end
  desc "Restart"
  task :restart do
  	sh("touch #{::Rails.root.to_s}/tmp/restart.txt")
	end
	
end

namespace :sass do
  desc 'Updates stylesheets if necessary from their Sass templates.'
  task :update => :environment do
    Sass::Plugin.update_stylesheets
  end
end