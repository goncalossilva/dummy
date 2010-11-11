Gem::Specification.new do |gem|
  gem.name              = "dummy"
  gem.version           = "0.9.1"
  gem.platform          = Gem::Platform::RUBY
  gem.authors           = ["Gonçalo Silva"]
  gem.email             = ["goncalossilva@gmail.com"]
  gem.homepage          = "http://github.com/goncalossilva/dummy"
  gem.summary           = "Generates dummy data"
  gem.description       = "A Ruby library to generate clever dummy data"
  gem.rubyforge_project = gem.name

  gem.required_rubygems_version = ">= 1.3.6"

  gem.files        = Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "{lib}/**/*.yml", "LICENSE", "*.md"]
  
  gem.require_path = "lib"
end
