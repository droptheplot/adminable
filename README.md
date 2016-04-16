# Adminable

[![Gem Version](https://badge.fury.io/rb/adminable.svg)](https://badge.fury.io/rb/adminable)
[![Build Status](https://travis-ci.org/droptheplot/adminable.svg?branch=master)](https://travis-ci.org/droptheplot/adminable)
[![Code Climate](https://codeclimate.com/github/droptheplot/adminable/badges/gpa.svg)](https://codeclimate.com/github/droptheplot/adminable)
[![Test Coverage](https://codeclimate.com/github/droptheplot/adminable/badges/coverage.svg)](https://codeclimate.com/github/droptheplot/adminable/coverage)

Simple admin interface for Ruby on Rails applications.

## Features

* Built with common Rails controllers with a small DSL.
* Supports namespaced models.
* Has simple search with [Ransack](https://github.com/activerecord-hackery/ransack).
* Uses [Bootstrap](https://github.com/twbs/bootstrap) 4.0.
* Handles a lot of associations with [Clusterize.js](https://github.com/NeXTs/Clusterize.js).
* Has built-in WYSIWYG editor [TinyMCE](https://github.com/tinymce/tinymce).
* Mobile friendly.

![Example1](https://raw.githubusercontent.com/droptheplot/adminable/master/screenshots/1.png)

![Example2](https://raw.githubusercontent.com/droptheplot/adminable/master/screenshots/2.png)

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

## Getting Started

#### Generating Resources

For example you have model `User`, then run:

```bash
rails g adminable:resource user
# => create  app/controllers/adminable/users_controller.rb
```

For namespaced models, like `Blog::Post`, use:

```bash
rails g adminable:resource blog/post
# => create  app/controllers/adminable/blog/posts_controller.rb
```

#### Customizing Attributes

You can update attributes with simple DSL inside `set_attributes` block:

##### For existing attributes

```ruby
  set(name, options = {})
```

##### For new attributes

```ruby
  add(name, type, options = {})
```

##### Examples

```ruby
class Adminable::Blog::PostsController < Adminable::ResourcesController
  set_attributes do |attributes|
    # Enables search for title column
    attributes.set :title, search: true

    # Hides title from new and edit pages
    attributes.set :title, form: true

    # Adds wysiwyg plugin and hides from index table
    attributes.set :text, wysiwyg: true, index: false

    # Adds new attribute `password` with type `string` and some default options
    attributes.add :password, :string, :wysiwyg: true, index: false
  end
end
```

## Built-in Attributes

List of attributes with default parameters.

|            | index? | form? | center? | wysiwyg? |
|------------|--------|-------|---------|----------|
| String     |    +   |   +   |         |          |
| Text       |    +   |   +   |         |     +    |
| Integer    |    +   |   +   |    +    |          |
| Float      |    +   |   +   |    +    |          |
| Decimal    |    +   |   +   |    +    |          |
| DateTime   |    +   |   +   |         |          |
| Boolean    |    +   |   +   |    +    |          |
| Belongs To |        |   +   |         |          |
| Has Many   |        |   +   |         |          |

## Contributing

1. Fork it (https://github.com/droptheplot/adminable/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
