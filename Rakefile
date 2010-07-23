require "rake"
require "rspec"
require "rspec/core/rake_task"

gemspec = eval(File.read(Dir["*.gemspec"].first))

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end

desc "Build gem locally"
task :build => :gemspec do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir "pkg" unless File.exists? "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end

desc "Install gem locally"
task :install => :build do
  system "gem install pkg/#{gemspec.name}-#{gemspec.version} --no-ri --no-rdoc"
end

desc "Clean automatically generated files"
task :clean do
  FileUtils.rm_rf "pkg"
end

namespace :test do
  desc "Run all tests"
  RSpec::Core::RakeTask.new("all") do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.spec_opts = ["-c", "-f n"]
  end
  
  desc "Run tests on the fake data generators"
  RSpec::Core::RakeTask.new("dummy_generators") do |t|
    t.pattern = "spec/*_spec.rb"
    t.spec_opts = ["-c", "-f d"]
  end
  
  desc "Run tests on the Rails generator"
  RSpec::Core::RakeTask.new("rails_generator") do |t|
    t.pattern = "spec/generator/*_spec.rb"
    t.spec_opts = ["-c", "-f d"]
  end
end
