# -*- coding: utf-8 -*-
require 'ostruct'

module SiteseekerNormalizer
  class Parse
    def initialize(raw_response, options={})
      @options = { encoding: "UTF-8" }.merge(options)
      @doc = Nokogiri::HTML(raw_response, nil, @options[:encoding])
      clean_up
      @doc = @doc.xpath("/html/body")
    end

    def entries
      @doc.css("dl.ess-hits dt").map do |entry|
        next if entry.css('a').nil?
        Entry.new(entry)
      end.compact
    end

    def category_groups
      @doc.css("[id^=essi-bd-cg-]").map do |category_group|
        OpenStruct.new(
          title: category_group.css(".ess-cat-bd-heading").text.strip.gsub(/:$/, ""),
          categories: category_group.css(".ess-cat-bd-category").map { |entry| Category.new(entry) }
        )
      end
    end

    def category_all
      all = @doc.css("p.ess-cat-bd-all")
      OpenStruct.new(
        title: all.css("strong").text,
        query: rewrite_query(all.xpath("strong/a/@href").text),
        hits: all.css(".ess-num").text.strip,
        current?: !!all.xpath("@class").text.match("ess-current")
      )
    end

    def sorting
      @doc.css('div.ess-sortlinks').xpath("a | span[@class='ess-current']").map do |sort_by|
        next if sort_by.text.downcase.strip == "kategori"
        OpenStruct.new(
          text: sort_by.text.strip,
          query: URI::parse(sort_by.xpath("@href").text).query,
          current: sort_by.xpath("@href").empty?
        )
      end.compact
    end

    def total
      @doc.css('#essi-hitcount').text.to_i
    end

    def more_query
      URI::parse(@doc.xpath("//*[@class='ess-respages']/*[@class='ess-next']/@href").text).query
    end

    def editors_choice
      @doc.xpath("//*[@class='ess-bestbets']/dt").map do |ec|
        OpenStruct.new(
          text: ec.xpath("a").text,
          url: ec.xpath("a/@href").text,
          summary: ec.xpath("following-sibling::dd[1]").text
        )
      end
    end

    def suggestions
      @doc.css(".ess-spelling a").map do |suggestion|
        OpenStruct.new(text: suggestion.text, url: rewrite_query(suggestion.xpath("@href").text))
      end
    end

    private
      def rewrite_query(url)
        URI::parse(url).query
      end

      # Cleanup some crap
      def clean_up
        @doc.css(".ess-separator").remove
        @doc.css("@title").remove
        @doc.css("@onclick").remove
        @doc.css("@tabindex").remove
        @doc.css(".ess-label-hits").remove
        @doc.css(".ess-clear").remove
      end
  end
end
