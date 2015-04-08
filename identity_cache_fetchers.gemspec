$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "identity_cache_fetchers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "identity_cache_fetchers"
  s.version     = IdentityCacheFetchers::VERSION
  s.authors     = ["Kevin Bongart"]
  s.email       = ["contact@kevinbongart.net"]
  s.homepage    = "https://github.com/KevinBongart/identity_cache_fetchers"
  s.summary     = "ActiveRecord#fetch_or_initialize and ActiveRecord#fetch_or_create for IdentityCache"
  s.description = "ActiveRecord#fetch_or_initialize and ActiveRecord#fetch_or_create for IdentityCache"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "identity_cache"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
