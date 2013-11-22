require "siteseeker_normalizer"
require 'nokogiri'
require "yaml"

begin
  SPEC_CONFIG = YAML.load_file("./spec/spec_config.yml")
rescue
  puts "ERROR: You need to copy the spec/spec_config.yml.example file"
  puts "       and add your Siteseeker account before running the tests."
  exit
end
