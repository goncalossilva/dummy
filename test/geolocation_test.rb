require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyGeolocationTests
  class DummyGeolocationTest < Test::Unit::TestCase
    def test_generates_valid_latitudes
      assert_match VALIDATE[:geolocation], Dummy::Geolocation.lat.to_s
      assert VALIDATE[:latitude_max] >= Dummy::Geolocation.lat and VALIDATE[:latitude_min] <= Dummy::Geolocation.lat 
    end
    
    def test_generates_valid_longitudes
      assert_match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/, Dummy::Geolocation.lng.to_s
      assert VALIDATE[:longitude_max] >= Dummy::Geolocation.lng and VALIDATE[:longitude_min] <= Dummy::Geolocation.lng
    end
  end
end
