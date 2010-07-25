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

