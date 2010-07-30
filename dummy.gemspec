Gem::Specification.new do |gem|
  gem.name              = "dummy"
  gem.version           = "0.5"
  gem.platform          = Gem::Platform::RUBY
  gem.authors           = ["Gonçalo Silva"]
  gem.email             = ["goncalossilva@gmail.com"]
  gem.homepage          = "http://github.com/goncalossilva/dummy"
  gem.summary           = "Generates and imports dummy data for Rails 3 applications"#"Generates fake data and test routes and runs performance tests with it"
  gem.description       = "Generates consistent fake data and allows you to insert it to the database"#"Generates test routes and consistent fake data, inserts it to the database and runs performance tests with them"
  gem.rubyforge_project = gem.name

  gem.required_rubygems_version = ">= 1.3.7"
  
  gem.add_dependency "rails", ">= 3.0.0.rc"

  gem.files        = Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "LICENSE", "*.md"]
  
  gem.require_path = "lib"
end
