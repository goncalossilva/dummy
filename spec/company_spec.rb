require "spec_helper"

describe Gremlin::Company do
  it "generates valid company names" do
    Gremlin::Company.name.should match /[ a-z]+/
  end
  
  it "generates valid company catch phrases" do
    Gremlin::Company.catch_phrase.should match /[ a-z]+/
    Gremlin::Company.catch_phrase.should match /\s/
  end
  
  it "generates valid corporate bullshit" do
    Gremlin::Company.bs.should match /[ a-z]+/
    Gremlin::Company.bs.should match /\s/
  end
end
