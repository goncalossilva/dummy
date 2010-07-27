require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    test "generates valid company names" do
      assert_match VALIDATE[:company_name], Dummy::Company.name
    end
    
    test "generates valid company catch phrases" do
      assert_match VALIDATE[:company_catch_phrase], Dummy::Company.catch_phrase
    end
    
    test "generates valid corporate bullshit" do
      assert_match VALIDATE[:company_bs], Dummy::Company.bs
    end
  end
end
