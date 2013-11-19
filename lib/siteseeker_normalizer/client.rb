# -*- coding: utf-8 -*-
require 'open-uri'
require 'uri'

module SiteseekerNormalizer
  class Client
    def initialize(siteseeker_url, options={})
      @base_search_url = "#{siteseeker_url}?oenc=UTF-8&"
      @options = { read_timeout: 1 }.merge(options)
    end

    # Send a GET request to the Siteseeker server and create a Nokogiri doc from the returned HTML
    def search(query)
      begin
        html = open("#{@base_search_url}#{query}", read_timeout: @options[:read_timeout]).read
        Response.new(html)
      rescue Exception => e
        "SiteseekerNormalizer error: #{e}" # TODO: handle error
      end
    end
  end
end
