

## Installation

In your `Gemfile`

```ruby
gem "reactive_rails_generator"
```

then

```ruby
bundle update
```

### Usage

```ruby
rails g reactrb:install
```

Options are :
* --reactive-router to install reactive-router too
* --reactive-record to install reactive-record too
* --opal-jquery to install opal-jquery in the js application manifest
* --all to do all the above

```ruby
rails g reactrb:component Home::Show
```

Will make the component app/react/components/home/show.rb
