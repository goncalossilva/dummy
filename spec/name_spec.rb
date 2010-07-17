require "spec_helper"

describe Gremlin::Name do
  it "generates a valid first name" do
    Gremlin::Name.first_name.should match /^[A-Z][a-z']+$/
  end
  
  it "generates a valid last name" do
    Gremlin::Name.last_name.should match /^[A-Z][a-z']+$/
  end
  
  it "generates a valid name" do
    Gremlin::Name.name.should match /^[A-Za-z\. ]*([A-Z][a-z ]+){2}[A-Za-z\. ]*$/
  end
end
