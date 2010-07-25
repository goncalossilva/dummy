require "rubygems"
require "dummy"
require "generators/dummy_generator"
require "test/unit"
require "rails/all"
require "rails/generators"
require "rails/generators/test_case"

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails_test'))
  end
end

def create_test_application
  Rails::Generators::AppGenerator.start(["#{Rails.root}"])
  
  templates_dir = File.expand_path("generators/templates", File.dirname(__FILE__))
  %w(child parent grand_parent).each do |model|
    copy_file "#{templates_dir}/#{model}.rb", "#{Rails.root}/app/models/#{model}.rb"
  end
end

