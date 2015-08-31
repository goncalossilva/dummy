require_relative 'test_helper'

module DummyAddressTests
  class DummyAddressTest < Test::Unit::TestCase
    def test_generates_valid_us_zip_codes
      assert_match VALIDATE[:zip_code], Dummy::Address.zip_code
    end
    
    def test_generates_valid_us_state
      assert_match VALIDATE[:us_state], Dummy::Address.us_state
    end
    
    def test_generates_valid_short_name_for_us_state
      assert_match VALIDATE[:us_state_short], Dummy::Address.us_state_short
    end
    
    def test_generates_a_valid_street_name
      assert_match VALIDATE[:street_name], Dummy::Address.street_name
    end
    
    def test_generates_a_valid_street_address
      assert_match VALIDATE[:street_address], Dummy::Address.street_address
    end
    
    def test_generates_a_valid_neighborhood
      assert_match VALIDATE[:neighborhood], Dummy::Address.neighborhood
    end
  end
end
