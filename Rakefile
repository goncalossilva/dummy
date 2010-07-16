require 'rake'
require 'spec/rake/spectask'

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
  Spec::Rake::SpecTask.new("all") do |t|
    t.spec_files = FileList['spec/*_spec.rb']
    t.spec_opts = ["-c", "-f n"]    
  end
  
  desc "Run a specific test file"
  task :specific, :name do |t, args|
    system "spec spec/#{args.name}_spec.rb -c -f n"
  end
end


