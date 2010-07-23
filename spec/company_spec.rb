require "spec_helper"

describe Dummy::Company do
  it "generates valid company names" do
    Dummy::Company.name.should match /[ a-z]+/
  end
  
  it "generates valid company catch phrases" do
    Dummy::Company.catch_phrase.should match /[ a-z]+/
    Dummy::Company.catch_phrase.should match /\s/
  end
  
  it "generates valid corporate bullshit" do
    Dummy::Company.bs.should match /[ a-z]+/
    Dummy::Company.bs.should match /\s/
  end
end
