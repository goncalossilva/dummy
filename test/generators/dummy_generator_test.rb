require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
require "rails/generators/rails/app/app_generator"
require "rails/generators/rails/model/model_generator"

class DummyGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Dummy::DataGenerator
  arguments []

  setup :prepare_destination

  test 'Dummy data is generated' do
    Rails::Generators::AppGenerator.start(["#{Rails.root}"])
    Rails::Generators::ModelGenerator.start(["name:string age:integer", "ActiveRecord"])
    run_generator
  end
end

