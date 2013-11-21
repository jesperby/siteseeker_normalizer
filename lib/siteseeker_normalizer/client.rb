# -*- coding: utf-8 -*-
require 'open-uri'
require 'uri'

module SiteseekerNormalizer
  class Client
    def initialize(account, index, options={})
      @options = { read_timeout: 5, encoding: "UTF-8" }.merge(options)
      @base_search_url = "http://#{account}.appliance.siteseeker.se/search/#{index}/?oenc=#{@options[:encoding]}"
    end

    def search(query)
      if query.is_a? Hash
        query = URI.encode_www_form(query)
      else
        query = "q=#{query}"
      end

      html = open("#{@base_search_url}&#{query}", read_timeout: @options[:read_timeout]).read
      Parse.new(html, @options[:encoding])
    end
  end
end
