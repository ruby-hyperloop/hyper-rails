Gem::Specification.new do |s|
  s.name        = 'hyper-rails'
  s.version     = '0.4.1'
  s.summary     = 'Hyperloop generators for Rails'
  s.description = 'This gem provide rails generators for Hyperloop'
  s.authors     = ['Loic Boutet']
  s.email       = 'loic@boutet.com'
  s.files       = ['lib/hyper-rails.rb',
                   'lib/generators/hyperloop/install_generator.rb',
                   'lib/generators/hyperloop/component_generator.rb',
                   'lib/generators/hyperloop/router_generator.rb',
                   'lib/generators/hyperloop/templates/component_template.rb',
                   'lib/generators/hyperloop/templates/router_template.rb']
  s.homepage    = 'https://github.com/ruby-hyperloop/hyper-rails'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rails', '>= 4.0.0'

  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'chromedriver-helper'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'

end
