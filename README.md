# TabooSearch

Taboo search to solve travelling salesman.

## Installation

Add this line to your application's Gemfile:

    gem 'taboo_search'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taboo_search

## Usage

TabooSearch::TabooSearch.new.search([[50, 50], [70, 70]], 15, 50, 100)

15 - taboo list size
50 - max candidates
100 - max iterations

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
