require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyPhoneNumberTests
  class DummyPhoneNumberTest < Test::Unit::TestCase
    test "generates a valid phone number" do
      assert_match /^(1-)?\(?\d{3}\)?[-\.\)]\d{3}[-\.]\d{4}( x\d{3,5})?$/, Dummy::PhoneNumber.phone_number
    end
    
    test "generates a valid short phone number" do
      assert_match /^\d{3}-\d{3}-\d{4}$/, Dummy::PhoneNumber.short_phone_number
    end
  end
end
