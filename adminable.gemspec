$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'adminable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'adminable'
  s.version     = Adminable::VERSION
  s.authors     = ['Sergey Novikov']
  s.email       = ['novikov359@gmail.com']
  s.homepage    = 'https://github.com/droptheplot/adminable'
  s.summary     = 'Simple admin interface for Ruby on Rails applications.'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 4.2', '< 5.1'
  s.add_dependency 'haml-rails', '~> 0.9.0'
  s.add_dependency 'sass-rails', '~> 5.0.4'
  s.add_dependency 'jquery-rails', '~> 4.0.4'
  s.add_dependency 'bootstrap', '~> 4.0.0.alpha3'
  s.add_dependency 'rails-assets-tether', '>= 1.1.0'
  s.add_dependency 'faker', '>= 1.6.1'
  s.add_dependency 'kaminari', '>= 0.16.2'
  s.add_dependency 'ransack', '>=1.7.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara', '~> 2.6.2'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'devise'
end
