require "spec_helper"

describe Dummy::Geolocation do
  it "generates valid latitudes" do
    Dummy::Geolocation.lat.to_s.should match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/
    Dummy::Geolocation.lat.should be <= 9e10
    Dummy::Geolocation.lat.should be >= -9e10
    
  end
  
  it "generates valid longitudes" do
    Dummy::Geolocation.lng.to_s.should match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/
    Dummy::Geolocation.lng.should be <= 1.8e11
    Dummy::Geolocation.lng.should be >= -9e11
  end
end
