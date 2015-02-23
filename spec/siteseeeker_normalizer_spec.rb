# -*- coding: utf-8 -*-
require 'spec_helper'

describe SiteseekerNormalizer do
  before do
    raw_results = open('spec/fixtures/barn.html').read
    @results = SiteseekerNormalizer::Parse.new(raw_results, encoding: 'UTF-8')
  end

  context '#results' do
    it 'must have number of hits' do
      expect(@results.total).to be_a Fixnum
    end

    it 'must have items' do
      expect(@results.entries.count).to be > 0
    end

    context '#entries' do
      it 'must have an order number' do
        expect(@results.entries.first.number).to eq 1
      end

      it 'must have a title' do
        expect(@results.entries.first.title).to be_a String
      end

      it 'must have an extract' do
        expect(@results.entries.first.summary).to be_a String
      end

      it 'must have a breadcrumb' do
        expect(@results.entries.first.breadcrumbs).to be_an Array
      end

      it 'must have a category' do
        expect(@results.entries.first.category).to be_a String
      end

      it 'must have a date string' do
        expect(@results.entries.first.date).to be_a String
      end
    end

    it 'must have sorting' do
      expect(@results.sorting).to be_an Array
    end

    it 'must have a first sorting entry with text' do
      expect(@results.sorting.first.text).to be_a String
    end

    it 'must have a second sorting entry with an url' do
      expect(@results.sorting[1].query).to be_a String
    end

    it 'must have a query string for getting more results' do
      expect(@results.more_query).to be_a String
    end

    it 'must have a categories' do
      expect(@results.category_groups).to be_an Array
    end

    it 'must show a spelling suggestions' do
      raw_results = open('spec/fixtures/barnomsrg.html').read
      results = SiteseekerNormalizer::Parse.new(raw_results, encoding: 'UTF-8')
      expect(results.suggestions.count).to be > 0
    end
  end
end
