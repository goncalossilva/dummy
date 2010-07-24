require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyAddressTests
  class DummyAddressTest < Test::Unit::TestCase
    test "generates valid US zip codes" do
      assert_match /^([0-9]{5}-[0-9]{4}|[0-9]{5})$/, Dummy::Address.zip_code
    end
  end
end
