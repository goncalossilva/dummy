require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyTests
  class DummyTest < Test::Unit::TestCase    
    MAGIC_GENERATION.each do |test, data|
      data[:types].each do |type|
        data[:names].each do |name|
          class_eval <<-EOV
            def test_magic_generation_of_#{test.to_s}_for_#{type}_column_named_#{name}
              assert_match VALIDATE[:#{test}], Dummy.magic_data("#{name}", :#{type}).to_s
            end
          EOV
        end
      end
    end
  end
end
