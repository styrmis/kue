$LOAD_PATH << "." unless $LOAD_PATH.include?(".")
require 'logger'
require "rubygems"
require "bundler"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'pry'
require 'active_record'
require File.expand_path('../../lib/kue', __FILE__)


active_record_configuration = YAML.load_file(File.expand_path('../config/database.yml', __FILE__))

ActiveRecord::Base.configurations = active_record_configuration
ActiveRecord::Base.establish_connection(:sqlite3)

ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))
ActiveRecord::Base.default_timezone = :utc

ActiveRecord::Migration.verbose = false
load(File.expand_path('../../lib/generators/kue/install/templates/migration.rb', __FILE__))

#Run the migration
KueSettingsTableCreateMigration.new.up

RSpec.configure do |configuration|
  configuration.after(:each) do
    KueStore.destroy_all
  end
end
