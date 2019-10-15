require 'mina/git'
require 'mina/deploy'

set :domain, 'DOMAIN'
set :user, 'USER'
set :deploy_to, '/home/USER/app'
set :repository, 'REPO_URL'
set :branch, 'BRANCH'
set :shared_files, fetch(:shared_files, []).push('.env.production.secret')

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'deploy:cleanup'
    on :launch do
      docker_compose = 'docker-compose -p APP_NAME -f docker-compose-production.yml'
      command "#{docker_compose} pull"
      command "#{docker_compose} build"
      command "#{docker_compose} up -d"
    end
  end
end
