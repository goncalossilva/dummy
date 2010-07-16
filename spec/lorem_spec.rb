require "spec_helper"

describe Gremlin::Lorem do
  it "generates a valid sentence" do
    Gremlin::Lorem.sentence.should match /^[A-Z][a-z]* ([a-z ]+){3} [a-z]+\.$/
  end
  
  it "generates a valid group of sentences" do
    Gremlin::Lorem.sentences.should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){3}$/
  end
  
  it "generates a valid paragraph" do
    Gremlin::Lorem.paragraph.should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){9}$/
  end
  
  it "generates a valid group of paragraphs" do
    Gremlin::Lorem.paragraphs.gsub!("\n", " ").should match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){27}$/
  end
end
