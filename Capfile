# Load DSL and set up stages
require 'dotenv'
Dotenv.load
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
require 'capistrano/rbenv'
# require 'capistrano/chruby'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
# require 'capistrano/passenger'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano3/unicorn'
# require 'capistrano/sidekiq/monit' #to require monit tasks (V0.2.0+)
require 'slackistrano/capistrano'
require_relative 'lib/capistrano/deploy_messaging'
require 'capistrano/sidekiq'
require 'rollbar/capistrano3'
require 'capistrano/sitemap_generator'

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
