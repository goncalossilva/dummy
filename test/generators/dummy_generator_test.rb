require File.expand_path(File.dirname(__FILE__) + "../test_helper")
require "rails/all"

module DummyGeneratorsTest
  class DummyGeneratorTest < Test::Unit::TestCase
    include ActiveSupport::Testing::Isolation

    def setup
      build_app
      boot_rails

      app_file "app/models/parent.rb", <<-MODEL
      class Parent
        has_many :sons
        has_many :daughters
      end
      MODEL
      
      app_file "app/models/son.rb", <<-MODEL
      class Son
        belongs_to :parent
      end
      MODEL
      
      app_file "app/models/daughter.rb", <<-MODEL
      class Daughter
        belongs_to :parent
      end
      MODEL
      
      app_file "app/models/banana.rb", <<-MODEL
      class Banana
      end
      MODEL
    end
  end
  
  test "it generates the result files" do
    
  end
end
