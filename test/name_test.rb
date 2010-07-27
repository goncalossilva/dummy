require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyNameTests
  class DummyNameTest < Test::Unit::TestCase
    test "generates a valid first name" do
      assert_match VALIDATE[:single_name], Dummy::Name.first_name
    end
    
    test "generates a valid last name" do
      assert_match VALIDATE[:single_name], Dummy::Name.last_name
    end
    
    test "generates a valid name" do
      assert_match VALIDATE[:name], Dummy::Name.name
    end
  end
end
