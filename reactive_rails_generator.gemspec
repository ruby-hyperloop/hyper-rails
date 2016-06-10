Gem::Specification.new do |s|
  s.name        = 'reactrb-rails-generator'
  s.version     = '0.2.0'
  s.summary     = 'Reactrb generators for rails'
  s.description = 'This gem provide rails generators for reactrb'
  s.authors     = ['Loic Boutet']
  s.email       = 'loic@boutet.com'
  s.files       = ['lib/reactrb-rails-generator.rb',
                   'lib/generators/reactrb/install_generator.rb',
                   'lib/generators/reactrb/component_generator.rb',
                   'lib/generators/reactrb/router_generator.rb',
                   'lib/generators/reactrb/templates/component_template.rb',
                   'lib/generators/reactrb/templates/router_template.rb']
  s.homepage    = 'https://github.com/reactrb/reactrb-rails-generator'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rails', ['>= 4.0.0']
end
