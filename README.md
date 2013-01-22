# SimpleDateFix

Fixes for date queries using AWS::Record::Model.  This gem is based on
work done by [daniel-nelson](https://github.com/daniel-nelson) in [this
pull request to the 'aws-sdk'
gem.](https://github.com/aws/aws-sdk-ruby/pull/22)
Thanks, Daniel!

## Installation

Add this line to your application's Gemfile:

    gem 'simple_date_fix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_date_fix

## Usage

Now you can query your `datetime_attr`s.

```ruby
class Event < AWS::Record::Model
  datetime_attr :timestamp
end

e = Event.create!(:timestamp => Time.now - 6.hours)

Event.where("timestamp > ?",Time.now - 7.hours).first
# => e

Event.where("timestamp > ?",Time.now - 5.hours).first
# => nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
