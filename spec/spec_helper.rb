ENV['RAILS_ENV'] ||= 'test'

require 'codeclimate-test-reporter'

SimpleCov.start
CodeClimate::TestReporter.start

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'factory_girl_rails'
require 'database_cleaner'
require 'faker'

ActiveRecord::Migration.maintain_test_schema!

if ActiveRecord::Migrator.needs_migration?
  ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.include Rails.application.routes.url_helpers
  config.include Adminable::Engine.routes.url_helpers

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
