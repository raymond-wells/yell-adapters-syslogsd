# Yell::Adapters::Syslogsd

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'yell-adapters-syslogsd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yell-adapters-syslogsd

## Usage

You can instantiate it like so:
```ruby
require 'yell-adapters-syslogsd'
logger = Yell.new :syslogsd, facility: 'my-app'
logger.info "Hello World"
```

### Errors treated as warnings with rsyslogd & logstash?  Use direct mapping:

```ruby
require 'yell-adapters-syslogsd'
logger = Yell.new :syslogsd, facility: 'my-app', mapping: :direct
logger.error 'This is an error'
logger.warn 'This is a warning'
```

### Using Structured Data
```ruby
logger.error "There was an exception", type: e.class, description: e.message
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/yell-adapters-syslogsd/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
