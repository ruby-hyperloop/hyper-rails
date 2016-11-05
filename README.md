

## Installation

In your `Gemfile`

```ruby
gem "hyper-rails"
```

then

```ruby
bundle install
```

### Usage

```ruby
rails g hyperloop:install
bundle update
```

<!-- Options are :
* --hyper-router to install hyper-router too
* --hyper-mesh to install hyper-mesh too
* --opal-jquery to install opal-jquery in the js application manifest
* --all to do all the above -->

```ruby
rails g hyperloop:component Home::Clock
```

Will make the component app/views/components/home/clock.rb

<!-- ```ruby
rails g hyperloop:router Home::Show
```

Will make the router component app/views/components/home/show.rb

Note that router components are components that mix-in the React::Router module.  Both normal components and routers are called the usual way from controllers or views using the render_component method. -->
