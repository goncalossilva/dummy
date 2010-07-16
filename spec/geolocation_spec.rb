require "spec_helper"

describe Gremlin::Geolocation do
  it "generates valid latitudes" do
    Gremlin::Geolocation.lat.to_s.should match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/
    Gremlin::Geolocation.lat.should be <= 9e10
    Gremlin::Geolocation.lat.should be >= -9e10
    
  end
  
  it "generates valid longitudes" do
    Gremlin::Geolocation.lng.to_s.should match /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/
    Gremlin::Geolocation.lng.should be <= 1.8e11
    Gremlin::Geolocation.lng.should be >= -9e11
  end
end
