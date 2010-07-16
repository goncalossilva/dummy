require "spec_helper"

describe Gremlin::Address do
  it "generates valid US zip codes" do
    Gremlin::Address.zip_code.should match /^([0-9]{5}-[0-9]{4}|[0-9]{5})$/
  end
  
  it "generates valid US states" do
    Gremlin::Address.us_state.should match /^([A-Z][a-z ]+)+$/
  end
  
  it "generates valid abbreviations for US states" do
    Gremlin::Address.us_state_short.should match /^[A-Z]{2}$/
  end
  
  it "generates valid cities" do
    Gremlin::Address.city.should match /^([A-Z][a-z \.]+)+$/
  end
  
  it "generates valid street names" do
    Gremlin::Address.street_name.should match /^([A-Z][a-z ]+){2}$/
  end
  
  it "generates valid street addresses" do
    Gremlin::Address.street_address.should match /^[0-9]{3,5} ([A-Z][a-z ]+){2}$/
  end
  
  it "generates valid neighborhoods" do
    Gremlin::Address.neighborhood.should match /^(([A-Z][a-z -]+)|of|\/)+$/
  end
end
