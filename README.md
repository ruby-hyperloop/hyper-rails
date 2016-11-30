
#  ![](https://github.com/Serzhenka/hyper-loop-logos/blob/master/hyper-rails_150.png)Hyper-rails

## Installation

This generator will install HyperReact and Opal in Rails 4.x or 5.x

In your `Gemfile`

```ruby
gem "hyper-rails"
```

then

```ruby
bundle install
rails g hyperloop:install
bundle update
```

This generator can also create HyperReact components.

<!-- Options are :
* --hyper-router to install hyper-router too
* --hyper-mesh to install hyper-mesh too
* --opal-jquery to install opal-jquery in the js application manifest
* --all to do all the above -->

### HyperReact Components

```ruby
rails g hyperloop:component Home::Clock
```

Which will make the component `Home::Clock` in  `app/views/components/home/clock.rb`

You can render a component directly from a controller:

```ruby
class HomeController < ApplicationController
  def clock
    render_component
  end
end
```

Or from a view:

```ruby
<%= react_component('Home::Clock') %>
```
See [ruby-hyperloop.io](http://ruby-hyperloop.io/) for further examples.

<!-- ```ruby
rails g hyperloop:router Home::Show
```

Will make the router component app/views/components/home/show.rb

Note that router components are components that mix-in the React::Router module.  Both normal components and routers are called the usual way from controllers or views using the render_component method. -->
