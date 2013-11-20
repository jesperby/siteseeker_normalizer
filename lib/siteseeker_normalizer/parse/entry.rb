# -*- coding: utf-8 -*-
module SiteseekerNormalizer
  class Parse
    class Entry
      def initialize(entry)
        @entry = entry
      end

      def number
        @entry.css('.ess-hitnum').text.to_i
      end

      def title
        @entry.css('a').first.text
      end

      def summary
        @entry.xpath("following-sibling::*[1]/div[@class='ess-hit-extract']").text.strip
      end

      def url
        @entry.css('a').first['href']
      end

      def content_type
        @entry.css('.ess-dtypelabel').text.gsub(/[\[\]]/, "").strip
      end

      def date
        @entry.xpath("following-sibling::dd[2]").css('.ess-date').text.strip
      end

      def breadcrumbs
        @entry.xpath("following-sibling::dd[1]/div[@class='ess-special']/ul/li[a]").map do |item|
          OpenStruct.new(text: item.css("a").text.strip, url: item.css("a/@href").text)
        end
      end

      def category
        @entry.xpath("following-sibling::*[2]").css('.ess-category').text.strip
      end
    end
  end
end
