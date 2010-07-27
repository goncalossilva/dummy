require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyTests
  class DummyTest < Test::Unit::TestCase    
    MAGIC_GENERATION.each do |test, data|
      data[:types].each do |type|
        data[:names].each do |name|
          class_eval <<-EOV
            test "magic generation of '#{test.to_s}' for #{type} column named '#{name}'" do
              assert_match VALIDATE[:#{test}], Dummy.magic_data("#{name}", :#{type}).to_s
            end
          EOV
        end
      end
    end
  end
end
