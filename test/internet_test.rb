require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyInternetTests
  class DummyInternetTest < Test::Unit::TestCase
    test "generates valid emails" do
      assert_match /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, Dummy::Internet.email
    end

    test "generates valid user names" do
      assert_match /^([^\s]+)$/i, Dummy::Internet.user_name
    end
    
    test "generates a valid password (MD5)" do
      assert_match /\S{32}/, Dummy::Internet.password
    end
    
    test "generates valid domains" do
      assert_match /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/, Dummy::Internet.url
    end
  end
end
