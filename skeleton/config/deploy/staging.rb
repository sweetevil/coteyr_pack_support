set(:deploy_to) {"/home/staging/web/#{application}-code"}
set(:public_path) {"/home/staging/web/#{application}-code/current/public"}
set :user, "staging"
set :password, ''
server staging_server, :app, :web
role :db, staging_server, primary: true
role :task_server, staging_server
