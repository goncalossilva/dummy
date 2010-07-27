require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    test "generates a valid sentence" do
      assert_match VALIDATE[:sentence], Dummy::Lorem.sentence
    end
    
    test "generates a valid group of sentences" do
      assert_match VALIDATE[:sentences], Dummy::Lorem.sentences
    end
    
    test "generates a valid paragraph" do
      assert_match VALIDATE[:paragraph], Dummy::Lorem.paragraph
    end
    
    test "generates a valid group of paragraphs" do
      assert_match VALIDATE[:paragraphs], Dummy::Lorem.paragraphs.gsub!("\n", " ")
    end
  end
end
