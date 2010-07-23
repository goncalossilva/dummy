require "spec_helper"

describe Dummy::Name do
  it "generates a valid first name" do
    Dummy::Name.first_name.should match /^[A-Z][a-z']+$/
  end
  
  it "generates a valid last name" do
    Dummy::Name.last_name.should match /^[A-Z][a-z']+$/
  end
  
  it "generates a valid name" do
    Dummy::Name.name.should match /^[A-Za-z\. ]*([A-Z][a-z ]+){2}[A-Za-z\. ]*$/
  end
end
