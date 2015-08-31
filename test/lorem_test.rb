require_relative 'test_helper'

module DummyCompanyTests
  class DummyCompanyTest < Test::Unit::TestCase
    def test_generates_a_valid_sentence
      assert_match VALIDATE[:sentence], Dummy::Lorem.sentence
    end
    
    def test_generates_a_valid_group_of_sentences
      assert_match VALIDATE[:sentences], Dummy::Lorem.sentences
    end
    
    def test_generates_a_valid_paragraph
      assert_match VALIDATE[:paragraph], Dummy::Lorem.paragraph
    end
    
    def test_generates_a_valid_group_of_paragraphs
      assert_match VALIDATE[:paragraphs], Dummy::Lorem.paragraphs#.gsub!("\n", " ")
    end
  end
end
