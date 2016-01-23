require "rails/generators"
module Reactrb
  class InstallGenerator < Rails::Generators::Base
    class_option :"reactive-record", :type => :boolean
    class_option :"opal-jquery", :type => :boolean
    class_option :"reactive-router", :type => :boolean
    class_option :all, :type => :boolean

    def inject_react_file_js
      inject_into_file 'app/assets/javascripts/application.js', after: "// about supported directives.\n" do <<-'JS'
//= require 'components'
//= require 'react'
//= require 'react_ujs'
      JS
      end

      if options[:"opal-jquery"] || options[:all]
        inject_into_file 'app/assets/javascripts/application.js', after: "//= require jquery_ujs\n" do <<-'JS'
Opal.load('components');
        JS
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
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  # add any requires that can ONLY run on client here
end
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

    def add_config
      application "config.assets.paths << ::Rails.root.join('app', 'react').to_s"
      application 'config.autoload_paths += %W(#{config.root}/app/react/components)'
      application 'config.autoload_paths += %W(#{config.root}/app/react/models)' if options[:"reactive-record"] || options[:all]
      application 'config.eager_load_paths += %W(#{config.root}/app/react/components)'
      application 'config.eager_load_paths += %W(#{config.root}/app/react/models)' if options[:"reactive-record"] || options[:all]
      application 'config.watchable_files.concat Dir["#{config.root}/app/react/**/*.rb"]', env: :development
      application 'config.react.variant = :development', env: :development
    end

    def add_gems
      gem 'reactive-ruby'
      gem 'react-rails', '~> 1.3.0'
      gem 'opal-rails', '>= 0.8.1'
      gem 'therubyracer', platforms: :ruby

      # optional gems
      gem 'reactive-router' if options[:"reactive-router"] || options[:all]
      gem 'reactive-record' if options[:"reactive-record"] || options[:all]
    end
  end
end
