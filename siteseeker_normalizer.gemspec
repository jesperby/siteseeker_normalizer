# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'siteseeker_normalizer/version'

Gem::Specification.new do |spec|
  spec.name          = "siteseeker_normalizer"
  spec.version       = SiteseekerNormalizer::VERSION
  spec.authors       = ["martent"]
  spec.email         = ["marten@thavenius.se"]
  spec.description   = %q{Siteseeker integration library}
  spec.summary       = %q{A Ruby Gem for making requests and parsing the response from Siteseeker to a structured object.}
  spec.homepage      = "https://github.com/malmostad/siteseeker_normalizer"
  spec.license       = "AGPL v3"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "bundler", "~> 1.6"
end
