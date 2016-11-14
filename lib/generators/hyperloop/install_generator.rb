require 'rails/generators'
module Hyperloop
  class InstallGenerator < Rails::Generators::Base
    class_option :'hyper-mesh', type: :boolean
    class_option :'opal-jquery', type: :boolean
    class_option :'hyper-router', type: :boolean
    class_option :all, type: :boolean

    def inject_react_file_js
      prepend_file 'app/assets/javascripts/application.js' do
        <<-'JS'
// added by hyper-rails:  These lines must preceed other requires especially turbo_links
//= require 'components'
//= require 'react_ujs'
        JS
      end
      append_file 'app/assets/javascripts/application.js', "Opal.load('components');\n"
    end

    def inject_engine_to_routes
      if options[:'hyper-mesh'] || options[:all]
        route 'mount HyperMesh::Engine => \'/rr\''
      end
    end

    def create_components_directory
      create_file 'app/views/components/.keep', ''
      if options[:'hyper-mesh'] || options[:all]
        create_file 'app/models/public/.keep', ''
      end
    end

    def create_policies_directory
      if options[:'hyper-mesh'] || options[:all]
        create_file 'app/policies/application_policy.rb', <<-RUBY
# app/policies/application_policy

# Policies regulate access to your public models
# The following policy will open up full access (but only in development)
# The policy system is very flexible and powerful.  See the documentation
# for complete details.
class ApplicationPolicy
  # Allow any session to connect:
  always_allow_connection
  # Send all attributes from all public models
  regulate_all_broadcasts { |policy| policy.send_all }
  # Allow all changes to public models
  allow_change(to: :all, on: [:create, :update, :destroy]) { true }
end if Rails.env.development?
        RUBY
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
#{"require 'hyper-router'\nrequire 'react_router'" if options[:'hyper-router'] || options[:all]}
#{'require \'hyper-mesh\'' if options[:'hyper-mesh'] || options[:all]}
#{'require \'models\''          if options[:'hyper-mesh'] || options[:all]}
require_tree './components'
      FILE

      if options[:'hyper-mesh'] || options[:all]
        create_file 'app/models/models.rb', <<-FILE
# app/models/models.rb
require_tree './public'
        FILE
      end
    end

    def add_config
      application 'config.assets.paths << ::Rails.root.join(\'app\', \'models\').to_s'
      application 'config.autoload_paths += %W(#{config.root}/app/views/components)'
      if options[:'hyper-mesh'] || options[:all]
        application 'config.autoload_paths += %W(#{config.root}/app/models/public)'
      end
      application 'config.eager_load_paths += %W(#{config.root}/app/views/components)'
      if options[:'hyper-mesh'] || options[:all]
        application 'config.eager_load_paths += %W(#{config.root}/app/models/public)'
      end
      application 'config.watchable_files.concat Dir["#{config.root}/app/views/**/*.rb"]',
                  env: :development
      application 'config.react.variant = :development', env: :development
    end

    def add_gems

      gem "opal-rails"
      gem "opal-browser"
      gem 'hyper-react'
      gem 'therubyracer', platforms: :ruby

      # optional gems
      if options[:'hyper-router'] || options[:all]
        gem 'react-router-rails', '~> 0.13.3'
        gem 'hyper-router'
      end
      gem 'hyper-mesh' if options[:'hyper-mesh'] || options[:all]
    end
  end
end
