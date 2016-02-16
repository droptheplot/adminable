$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cms'
  s.version     = Cms::VERSION
  s.authors     = ['Sergey Novikov']
  s.email       = ['novikov359@gmail.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Cms.'
  s.description = 'TODO: Description of Cms.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.0.0.beta2', '< 5.1'
  s.add_dependency 'haml-rails', '~> 0.9.0'
  s.add_dependency 'sass-rails', '~> 5.0.4'
  s.add_dependency 'jquery-rails', '~> 4.0.4'
  s.add_dependency 'bootstrap', '~> 4.0.0.alpha3'
  s.add_dependency 'rails-assets-tether', '>= 1.1.0'
  s.add_dependency 'faker', '>= 1.6.1'
  s.add_dependency 'coffee-rails', '>= 4.1.1'

  s.add_development_dependency 'sqlite3'
end
