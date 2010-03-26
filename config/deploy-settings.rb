#setting file for deployment
Capistrano::Configuration.instance(:must_exist).load do
  set :application, "app-name"
  set :use_sudo, false
  set :user, "username"
  set :password, 'password'
  set :domain, "www.site.com"
  set :repository,  "git repository"
end