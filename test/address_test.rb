require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyAddressTests
  class DummyAddressTest < Test::Unit::TestCase
    test "generates valid US zip codes" do
      assert_match /^([0-9]{5}-[0-9]{4}|[0-9]{5})$/, Dummy::Address.zip_code
    end
    
    test "generates valid US state" do
      assert_match /^([A-Z][a-z]+)+$/, Dummy::Address.us_state
    end
    
    test "generates valid short name for US state" do
      assert_match /^[A-Z]{2}$/, Dummy::Address.us_state_short
    end
    
    test "generates a valid street name" do
      assert_match /^[A-Z][a-z"]+ [A-Z][a-z]+$/, Dummy::Address.street_name
    end
    
    test "generates a valid street address" do
      assert_match /^\d+ [A-Z][a-z"]+ [A-Z][a-z]+$/, Dummy::Address.street_address
    end
  end
end
