Gem::Specification.new do |s|
  s.name        = 'reactive_rails_generator'
  s.version     = '0.1.2'
  s.date        = '2016-01-17'
  s.summary     = "React.rb generators for rails"
  s.description = "This gem provide rails generators for react.rb"
  s.authors     = ["Loic Boutet"]
  s.email       = 'loic@boutet.com'
  s.add_runtime_dependency "rails", [">= 4.0.0"]
  s.files       = [ "lib/reactive_rails_generator.rb",
                    "lib/generators/reactrb/install_generator.rb",
                    "lib/generators/reactrb/component_generator.rb",
                    "lib/generators/reactrb/templates/component_template.rb"
                  ]
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license       = 'MIT'
end