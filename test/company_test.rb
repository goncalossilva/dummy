require_relative 'test_helper'

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    def test_generates_valid_company_names
      assert_match VALIDATE[:company_name], Dummy::Company.name
    end
    
    def test_generates_valid_company_catch_phrases
      assert_match VALIDATE[:company_catch_phrase], Dummy::Company.catch_phrase
    end
    
    def test_generates_valid_corporate_bullshit
      assert_match VALIDATE[:company_bs], Dummy::Company.bs
    end
  end
end
