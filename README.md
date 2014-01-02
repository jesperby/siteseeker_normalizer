# Siteseeker Normalizer

[![Build Status](https://travis-ci.org/malmostad/siteseeker_normalizer.png)](https://travis-ci.org/malmostad/siteseeker_normalizer) [![Dependency Status](https://gemnasium.com/malmostad/siteseeker_normalizer.png)](https://gemnasium.com/malmostad/siteseeker_normalizer) [![Gem Version](https://badge.fury.io/rb/siteseeker_normalizer.png)](http://badge.fury.io/rb/siteseeker_normalizer)

Ruby gem for Siteseeker integration. Performs requests and parses the response from Siteseeker. Search results is available as a structured object.

## Requirements
* Ruby 1.9.3, 2.0.0 or 2.1.0.
* A [Siteseeker](http://www.siteseeker.se/) account.

## Installation

Add this line to your application's Gemfile:

    gem 'siteseeker_normalizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install siteseeker_normalizer

## Usage
Check out the the Rails app [Intranet Dashboard](https://github.com/malmostad/intranet-dashboard) in the `site_search` controller and views or the standalone Sinatra search app [Sitesearch](https://github.com/malmostad/sitesearch). Both are using memcached wrappers for the fetched search results.

```Ruby
require 'siteseeker_normalizer'

# Initialize a search client with your account name and a search index name.
client = SiteseekerNormalizer::Client.new("account_name", "index_name")

# Search query with a search string.
results = client.search("parkering")

# Search query with a Hash of parameters
# Used for category filtering, load more results etc. where the query comes from a previous result.
results = client.search(params)

# Fetch the results first and then parse. Useful for caching the response before parsing.
raw_results = client.fetch("parkering")
raw_results = client.fetch(params)
results = SiteseekerNormalizer::Parse.new(raw_results)

# Parsed response
results.total                      # => 1008
results.entries                    # => Array with result entries

# First entry in results
entry = results.entries.first
entry.title                        # => "Boendeparkering"
entry.summary                      # => "Boendeparkering finns snart i 19 ..."
entry.date                         # => "2013-12-17"
entry.breadcrumbs.first.text       # => "malmo.se"
entry.breadcrumbs.first.url        # => "http://www.malmo.se/Medborgare.html"
entry.category                     # => "Ämnessidor: Stadsplanering & trafik"

# Sorting, Array with sorting alternatives
results.sorting.first.text         # => "Relevans"
results.sorting.first.query        # => "q=parkering&t=simple&ls=2&d=0&d1=01&d2 ..."
results.sorting.first.current      # => false

# Query for loading more results
results.more_query                 # => "q=parkering&t=simple&ls=2&d=0&d1=01&d2 ..."

# Array with categories for the results, used for filtering
category_group = results.category_groups.first
category_group.title               # => "Ämnessidor"
category = category_group.categories.first
category.current?                  # => false
category.hits                      # => "12"
category.title                     # => "Biblioteken"
category.query                     # => "q=parkering&t=simple&ls=2&d=0&d1=01&d2 ..."

# Spelling suggestions
results = client.search("parkkering")
results.suggestions.first.text     # => "parkering"
results.suggestions.first.url      # => "q=parkering&t=simple&ls=2&d=0&d1=01& ..."
```

## Testing
Run:

    rspec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create or modify test cases
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## License
Released under AGPL version 3.

