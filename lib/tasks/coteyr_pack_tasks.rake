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
    plugin_dir = File.join(File.dirname(__FILE__), '..', '..')
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'public')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'test')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'config')], File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.gitignore'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.rvmrc'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.metrics'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', 'Capfile'), File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'script')], File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'app')], File.join(Rails.root), :verbose => true)
    
    puts "Finished."
    puts "========================="
    puts "Make sure to update the settings in config/initializers/exceptions.rb before you attempt"
    puts "to run any other tasks."
    puts "========================="
    puts "Pay special attention that you reload your environment (rvm)."
    puts "Then make sure to run bundle update."
    
  end
  desc "Update files when updating the gem. Will overwrite some files."
  task :update do
    plugin_dir = File.join(File.dirname(__FILE__), '..', '..')
    FileUtils.cp( File.join(plugin_dir, 'skeleton', 'Gemfile'),  ::Rails.root.to_s, :verbose=>true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.gitignore'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.rvmrc'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', '.metrics'), File.join(Rails.root), :verbose => true)
    FileUtils.cp( File.join(plugin_dir, 'skeleton', 'Capfile'), File.join(Rails.root), :verbose => true)
    FileUtils.cp_r( Dir[File.join(plugin_dir, 'skeleton', 'script')], File.join(Rails.root), :verbose => true)
    
    puts "Finished."
    puts "========================="
    puts "Some application files were overwritten make sure to check them against git."
    puts "before committing next time. You may also wish to run bundle update."
    puts "========================="
    puts "Pay special attention that you reload your environment (rvm)."
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
      if Rails.env == "production"
        sh("#{::Rails.root.to_s}/vendor/plugins/coteyr_pack/lib/log-anaylizer/bin/request-log-analyzer -f rails3 --output html --mail coteyr@coteyr.net #{::Rails.root.to_s}/log/#{Rails.env}.log")
      else
        sh("#{::Rails.root.to_s}/vendor/plugins/coteyr_pack/lib/log-anaylizer/bin/request-log-analyzer -f rails3 --output html --file /tmp/anaylizer.html #{::Rails.root.to_s}/log/#{Rails.env}.log")
      end
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