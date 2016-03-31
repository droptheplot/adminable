# Adminable

[![Gem Version](https://badge.fury.io/rb/adminable.svg)](https://badge.fury.io/rb/adminable)
[![Build Status](https://travis-ci.org/droptheplot/adminable.svg?branch=master)](https://travis-ci.org/droptheplot/adminable)
[![Code Climate](https://codeclimate.com/github/droptheplot/adminable/badges/gpa.svg)](https://codeclimate.com/github/droptheplot/adminable)

Simple admin interface for Ruby on Rails applications.

## Features

* Built with common Rails controllers without DSL.
* Supports namespaced models.
* Has simple search with Ransack.
* Uses Bootstrap 4.0.
* Mobile friendly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adminable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install adminable
```

## Built-in Attributes

List of attributes with default modifiable parameters.

##### String

* show: `true`
* center: `false`

##### Text

* show: `true`
* center: `false`
* wysiwyg: `true`

##### Integer

* show: `true`
* center: `true`

##### Float

* show: `true`
* center: `true`

##### Decimal

* show: `true`
* center: `true`

##### DateTime

* show: `true`
* center: `false`

##### Boolean

* show: `true`
* center: `true`

##### Belongs To

* show: `true`
* center: `false`

##### Has Many

* show: `true`
* center: `false`

## Contributing

1. Fork it (https://github.com/droptheplot/adminable/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
