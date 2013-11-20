# -*- coding: utf-8 -*-
require 'open-uri'
require 'uri'

module SiteseekerNormalizer
  class Client
    def initialize(siteseeker_url, options={})
      @base_search_url = "#{siteseeker_url}?oenc=UTF-8&"
      @options = { read_timeout: 5 }.merge(options)
    end

    # Send a GET request to the Siteseeker server and create a Nokogiri doc from the returned HTML
    def search(query)
      if query.is_a? Hash
        query = URI.encode_www_form(query)
      else
        query = "q=#{query}"
      end

      html = open("#{@base_search_url}#{query}", read_timeout: @options[:read_timeout]).read
      Response.new(html)
    end
  end
end
