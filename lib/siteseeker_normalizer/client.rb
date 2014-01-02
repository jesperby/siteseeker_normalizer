# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'
require 'uri'

module SiteseekerNormalizer
  class Client
    def initialize(account, index, options={})
      @options = { read_timeout: 5, encoding: "UTF-8" }.merge(options)
      @base_search_url = "http://#{account}.appliance.siteseeker.se/search/#{index}/?oenc=#{@options[:encoding]}"
    end

    def search(query)
      raw_response = fetch(query)
      Parse.new(raw_response, encoding: @options[:encoding])
    end

    def fetch(query)
      if query.is_a? Hash
        query = URI.encode_www_form(query)
      else
        query = "q=#{URI.encode_www_form_component(query)}"
      end
      open("#{@base_search_url}&#{query}", read_timeout: @options[:read_timeout]).read
    end
  end
end
