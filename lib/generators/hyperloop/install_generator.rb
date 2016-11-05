require 'rails/generators'
module Hyperloop
  class InstallGenerator < Rails::Generators::Base
    class_option :'reactive-record', type: :boolean
    class_option :'opal-jquery', type: :boolean
    class_option :'reactrb-router', type: :boolean
    class_option :all, type: :boolean

    def inject_react_file_js
      inject_into_file 'app/assets/javascripts/application.js',
                       after: "// about supported directives.\n" do
        <<-'JS'
//= require 'components'
//= require 'react_ujs'
        JS
      end
      inject_into_file 'app/assets/javascripts/application.js',
                       after: "//= require jquery_ujs\n" do
        <<-'JS'
Opal.load('components');
        JS
      end
    end

    def inject_engine_to_routes
      if options[:'reactive-record'] || options[:all]
        route 'mount ReactiveRecord::Engine => \'/rr\''
      end
    end

    def create_components_directory
      create_file 'app/views/components/.keep', ''
      if options[:'reactive-record'] || options[:all]
        create_file 'app/models/public/.keep', ''
      end
    end

    def create_manifests
      create_file 'app/views/components.rb', <<-FILE
# app/views/components.rb
require 'opal'
require 'react/react-source'
require 'hyper-react'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  # add any additional requires that can ONLY run on client here
end
#{"require 'reactrb-router'\nrequire 'react_router'" if options[:'reactive-router'] || options[:all]}
#{'require \'reactive-record\'' if options[:'reactive-record'] || options[:all]}
#{'require \'models\''          if options[:'reactive-record'] || options[:all]}
require_tree './components'
      FILE

      if options[:'reactive-record'] || options[:all]
        create_file 'app/models/models.rb', <<-FILE
# app/models/models.rb
require_tree './public'
        FILE
      end
    end

    def add_config
      application 'config.assets.paths << ::Rails.root.join(\'app\', \'models\').to_s'
      application 'config.autoload_paths += %W(#{config.root}/app/views/components)'
      if options[:'reactive-record'] || options[:all]
        application 'config.autoload_paths += %W(#{config.root}/app/models/public)'
      end
      application 'config.eager_load_paths += %W(#{config.root}/app/views/components)'
      if options[:'reactive-record'] || options[:all]
        application 'config.eager_load_paths += %W(#{config.root}/app/models/public)'
      end
      application 'config.watchable_files.concat Dir["#{config.root}/app/views/**/*.rb"]',
                  env: :development
      application 'config.react.variant = :development', env: :development
    end

    def add_gems

      gem 'react-rails'
      gem 'hyper-react'
      gem 'therubyracer', platforms: :ruby

      # optional gems
      if options[:'reactrb-router'] || options[:all]
        gem 'react-router-rails', '~> 0.13.3'
        gem 'reactrb-router'
      end
      gem 'reactive-record' if options[:'reactive-record'] || options[:all]
    end
  end
end
