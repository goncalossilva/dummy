require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyNameTests
  class DummyNameTest < Test::Unit::TestCase
    def test_generates_a_valid_first_name
      assert_match VALIDATE[:single_name], Dummy::Name.first_name
    end
    
    def test_generates_a_valid_last_name
      assert_match VALIDATE[:single_name], Dummy::Name.last_name
    end
    
    def test_generates_a_valid_name
      assert_match VALIDATE[:name], Dummy::Name.name
    end
  end
end
