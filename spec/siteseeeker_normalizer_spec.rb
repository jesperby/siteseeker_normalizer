# -*- coding: utf-8 -*-
require 'spec_helper'

describe SiteseekerNormalizer do
  before(:each) do
    raw_results = open("spec/fixtures/barn.html").read
    @results = SiteseekerNormalizer::Parse.new(raw_results, encoding: "UTF-8")
  end

  it "should have a number of hits" do
    @results.total.should be_a Fixnum
  end

  it "should have results" do
    @results.entries.count.should > 0
  end

  describe "result entry" do
    it "should have an order number" do
      @results.entries.first.number.should eq 1
    end

    it "should have a title" do
      @results.entries.first.title.should be_a String
    end

    it "should have an extract" do
      @results.entries.first.summary.should be_a String
    end

    it "should have a breadcrumb" do
      @results.entries.first.breadcrumbs.should be_an Array
    end

    it "should have a category" do
      @results.entries.first.category.should be_a String
    end

    it "should have a date string" do
      @results.entries.first.date.should be_a String
    end
  end

  it "should have sorting" do
    @results.sorting.should be_an Array
  end

  it "should have a first sorting entry with text" do
    @results.sorting.first.text.should be_a String
  end

  it "should have a second sorting entry with an url" do
    @results.sorting[1].query.should be_a String
  end

  it "should have a query string for getting more results" do
    @results.more_query.should be_a String
  end

  it "should have a categories" do
    @results.category_groups.should be_an Array
  end

  it "should show a spelling suggestions" do
    raw_results = open("spec/fixtures/barnomsrg.html").read
    results = SiteseekerNormalizer::Parse.new(raw_results, encoding: "UTF-8")
    results.suggestions.count.should > 0
  end
end
