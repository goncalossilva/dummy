require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    test "generates a valid sentence" do
      assert_match /^[A-Z][a-z]* ([a-z ]+){3} [a-z]+\.$/, Dummy::Lorem.sentence
    end
    
    test "generates a valid group of sentences" do
      assert_match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){3}$/, Dummy::Lorem.sentences
    end
    
    test "generates a valid paragraph" do
      assert_match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){9}$/, Dummy::Lorem.paragraph
    end
    
    test "generates a valid group of paragraphs" do
      assert_match /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){27}$/, Dummy::Lorem.paragraphs.gsub!("\n", " ")
    end
end
