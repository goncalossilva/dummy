require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyAddressTests
  class DummyAddressTest < Test::Unit::TestCase
    test "generates valid US zip codes" do
      assert_match VALIDATE[:zip_code], Dummy::Address.zip_code
    end
    
    test "generates valid US state" do
      assert_match VALIDATE[:us_state], Dummy::Address.us_state
    end
    
    test "generates valid short name for US state" do
      assert_match VALIDATE[:us_state_short], Dummy::Address.us_state_short
    end
    
    test "generates a valid street name" do
      assert_match VALIDATE[:street_name], Dummy::Address.street_name
    end
    
    test "generates a valid street address" do
      assert_match VALIDATE[:street_address], Dummy::Address.street_address
    end
  end
end
