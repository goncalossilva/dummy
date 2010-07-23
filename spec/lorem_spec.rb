require "spec_helper"

describe Dummy::Lorem do
  it "generates a valid sentence" do
    Dummy::Lorem.sentence.should match /^[A-Z][a-z]* ([a-z ]+){3} [a-z]+\.$/
  end
  
  it "generates a valid group of sentences" do
    Dummy::Lorem.sentences.should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){3}$/
  end
  
  it "generates a valid paragraph" do
    Dummy::Lorem.paragraph.should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){9}$/
  end
  
  it "generates a valid group of paragraphs" do
    Dummy::Lorem.paragraphs.gsub!("\n", " ").should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){27}$/
  end
end
