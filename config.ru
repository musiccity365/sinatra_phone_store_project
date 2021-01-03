require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# THIS FILE MOUNTS ALL CONTROLLERS

use Rack::MethodOverride 
run ApplicationController
use UsersController
use PhonesController
# use SessionsController
# use PostsController
