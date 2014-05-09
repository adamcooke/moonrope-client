$:.push File.expand_path("../lib", __FILE__)

require "moonrope_client/version"

Gem::Specification.new do |s|
  s.name        = "moonrope-client"
  s.version     = MoonropeClient::VERSION
  s.authors     = ["Adam Cooke"]
  s.email       = ["adam@atechmedia.com"]
  s.homepage    = "http://adamcooke.io"
  s.summary     = "A client library for the the Moonrope API server."
  s.description = "A full client library allows requests to made to Moonrope-enabled API endpoints."
  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.add_dependency "json", "~> 1.8", ">= 1.8.0"
  s.add_development_dependency 'yard', '~> 0.8', '>= 0.8.0'
  s.licenses    = ["MIT"]
end
