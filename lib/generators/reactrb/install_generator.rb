require "rails/generators"
module Reactrb
  class InstallGenerator < Rails::Generators::Base
    class_option :"reactive-record", :type => :boolean
    class_option :"opal-jquery", :type => :boolean
    class_option :"reactive-router", :type => :boolean
    class_option :all, :type => :boolean

    def inject_react_file_js
      inject_into_file 'app/assets/javascripts/application.js', after: "// about supported directives.\n" do <<-'RUBY'
//= require 'components'
//= require 'react_ujs'
      RUBY
      end

      if options[:"opal-jquery"] || options[:all]
        inject_into_file 'app/assets/javascripts/application.js', after: "//= require jquery_ujs\n" do <<-'RUBY'
//= require 'opal-jquery'
        RUBY
        end
      end

    end

    def inject_engine_to_routes
      if options[:"reactive-record"] || options[:all]
        route "mount ReactiveRecord::Engine => \"/rr\""
      end
    end

    def create_components_directory
      create_file "app/react/components/.keep", ""
      create_file "app/react/models/.keep", "" if options[:"reactive-record"] || options[:all]
    end

    def create_manifests
      create_file "app/react/components.rb", <<-FILE
# app/react/components.rb
require 'opal'
require 'reactive-ruby'
#{"require 'reactive-router'" if options[:"reactive-router"] || options[:all]}
#{"require 'reactive-record'" if options[:"reactive-record"] || options[:all]}
#{"require 'models'"          if options[:"reactive-record"] || options[:all]}
require_tree './components'
      FILE

      if options[:"reactive-record"] || options[:all]
        create_file "app/react/models.rb", <<-FILE
# app/react/components.rb
require_tree './models'
        FILE
      end
    end

    def add_gems
      gem 'reactive-ruby'
      gem 'react-rails', '~> 1.3.0'
      gem 'opal-rails', '>= 0.8.1'
      gem 'therubyracer', platforms: :ruby

      # optional gems
      gem 'opal-jquery'     if options[:"opal-jquery"]     || options[:all]
      gem 'reactive-router' if options[:"reactive-router"] || options[:all]
      gem 'reactive-record' if options[:"reactive-record"] || options[:all]
    end
  end
end