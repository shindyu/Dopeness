# Dopeness

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dopeness`. To experiment with that code, run `bin/console` for an interactive prompt.

***Parse a Verse, and Analayze the Rhyme.***

Analyze japanese text, rating  good rhyme.
Rating is using Ngram and Lebenstein.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dopeness'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dopeness

## Usage

```
require "dopeness"

Dopeness.dope("text")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dopeness. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dopeness project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dopeness/blob/master/CODE_OF_CONDUCT.md).
