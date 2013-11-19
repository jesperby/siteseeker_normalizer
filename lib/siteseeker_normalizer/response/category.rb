# -*- coding: utf-8 -*-
module SiteseekerNormalizer
  class Response
    class Category
      def initialize(category)
        @category = category
      end

      def title
        @category.css("a").text.strip
      end

      def query
        URI::parse(@category.css("a").first['href']).query.strip
      end

      def hits
        @category.css(".ess-num").text.strip
      end

      def current?
        !!@category.xpath("@class").text.match("ess-current")
      end
    end
  end
end
