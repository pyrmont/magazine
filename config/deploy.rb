default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :ssh_options, { :forward_agent => true }

set :user,        "deploy"
set :application, "magazine"
set :domain,      "deploy.inqk.net"
set :repository,  "build"
set :deploy_to,   "/var/www/magazine.inqk.net"
set :shared_path, "#{deploy_to}/shared"
set :use_sudo,    false
 
set :scm,        :none
set :deploy_via, :copy
set :copy_compression, :gzip

role :web, domain
role :app, domain # this can be the same as the web server
role :db,  domain, :primary => true # this can be the same as the web server
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
end

before 'deploy:update' do
  run_locally 'rm -rf build/*'
  run_locally 'bundle exec middleman build'
end

# after "deploy:finalize_update", "deploy:copy_config"
# after "deploy:copy_config", "deploy:copy_uploads"
# after "deploy:update", "deploy:cleanup"