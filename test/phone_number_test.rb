require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyPhoneNumberTests
  class DummyPhoneNumberTest < Test::Unit::TestCase
    test "generates a valid phone number" do
      assert_match VALIDATE[:phone_number], Dummy::PhoneNumber.phone_number
    end
    
    test "generates a valid short phone number" do
      assert_match VALIDATE[:phone_number_short], Dummy::PhoneNumber.phone_number_short
    end
  end
end
