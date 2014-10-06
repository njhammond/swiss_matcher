$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "swiss_matcher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "swiss_matcher"
  s.version     = SwissMatcher::VERSION
  s.authors     = ["Nicolas Hammond"]
  s.email       = ["gems@hammondsoftware.com"]
  s.homepage    = "TODO: A Home page. There is no home page for this project"
  s.summary     = "Given the state of a Swiss Bridge event, returns possible matches"
  s.description = "Longer description is 2BD"
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", 
    "ALGORITHM",
    "ATTRIBUTES",
    "AUTHORS",
    "BACKGROUND",
    "COMPUTER_MODEL",
    "DEFINITIONS",
    "Gemfile", 
    "Gemfile.lock", 
    "HISTORY",
    "LICENSE",
    "PERFORMANCE",
    "PROCESS",
    "README.md",
    "REQUIREMENTS",
    "RESOURCES",
    "STYLE",
    "TEST",
    "Rakefile", 
    "spec/*rb"
  ]
  # Generic test files.
  # More under ./standalone_tests
#  s.test_files = Dir["test/**/*"]

  # For testing
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
