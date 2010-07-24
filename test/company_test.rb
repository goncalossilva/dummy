require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    test "generates valid company names" do
      assert_match /[ a-z]+/, Dummy::Company.name
    end
    
    test "generates valid company catch phrases" do
      assert_match /[ a-z]+/, Dummy::Company.catch_phrase
      assert_match /\s/, Dummy::Company.catch_phrase
    end
    
    test "generates valid corporate bullshit" do
      assert_match /[ a-z]+/, Dummy::Company.bs
      assert_match /\s/, Dummy::Company.bs
    end
  end
end
