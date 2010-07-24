require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyGeolocationTests
  class DummyGeolocationTest < Test::Unit::TestCase
    test "generates valid latitudes" do
      assert_match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/, Dummy::Geolocation.lat.to_s
      assert 9e10 >= Dummy::Geolocation.lat and -9e10 <= Dummy::Geolocation.lat 
    end
    
    test "generates valid longitudes" do
      assert_match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/, Dummy::Geolocation.lng.to_s
      assert 1.8e11 >= Dummy::Geolocation.lng and -9e11 <= Dummy::Geolocation.lng
    end
  end
end
