# Adminable

[![Gem Version](https://badge.fury.io/rb/adminable.svg)](https://badge.fury.io/rb/adminable)
[![Build Status](https://travis-ci.org/droptheplot/adminable.svg?branch=master)](https://travis-ci.org/droptheplot/adminable)
[![Code Climate](https://codeclimate.com/github/droptheplot/adminable/badges/gpa.svg)](https://codeclimate.com/github/droptheplot/adminable)
[![Test Coverage](https://codeclimate.com/github/droptheplot/adminable/badges/coverage.svg)](https://codeclimate.com/github/droptheplot/adminable/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/droptheplot/adminable.svg)](https://gemnasium.com/github.com/droptheplot/adminable)


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

First things first. Add routes and create `application_controller.rb` class using generator:

```bash
rails g adminable:install
# => create app/controllers/adminable/application_controller.rb
# => insert config/routes.rb
```

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

##### Attributes Parameters

* `index` - *(true/false)* - Shows attribute on index page.
* `form` - *(true/false)* - Shows attribute on new/edit page.
* `center` - *(true/false)* - Adds `text-align: center` for attribute value on index page.
* `search` - *(true/false)* - Enables search for this attribute.

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

    # Adds new attribute `password` with type `string` and some options
    attributes.add :password, :string, wysiwyg: true, index: false

    # Adds new attribute `author`
    attributes << Adminable::Attributes::Types::String.new(:author)

    # Allows search for multiple attributes
    attributes.set :title, :body, search: true
  end
end
```

##### See Also

* Configured controller for Devise model: [app/controllers/adminable/users_controller.rb](https://github.com/droptheplot/adminable/blob/master/spec/dummy/app/controllers/adminable/users_controller.rb)

## Built-in Attributes

List of attributes with default parameters.

|            | index | form | center | wysiwyg |
|------------|-------|------|--------|---------|
| String     |   +   |   +  |        |         |
| Text       |   +   |   +  |        |    +    |
| Integer    |   +   |   +  |    +   |         |
| Float      |   +   |   +  |    +   |         |
| Decimal    |   +   |   +  |    +   |         |
| Date       |   +   |   +  |        |         |
| DateTime   |   +   |   +  |        |         |
| Time       |   +   |   +  |        |         |
| Timestamp  |   +   |   +  |        |         |
| Boolean    |   +   |   +  |    +   |         |
| Belongs To |       |   +  |        |         |
| Has Many   |       |   +  |        |         |

## Generating Partials

You can use generator to copy original partial to your application.

`rails g adminable:partial [layout] [type] [resource]`

* `layout` - `index` or `form`.
* `type` - `string`, `text` etc. See [Built-in Attributes](#built-in-attributes).
* `resource` - Use controller name (e.g. `users`) to replace partial only for single controller or leave blank to replace partials for all controllers.

## Contributing

1. Fork it (https://github.com/droptheplot/adminable/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
