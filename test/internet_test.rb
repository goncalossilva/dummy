require File.expand_path(File.dirname(__FILE__) + "/test_helper")

module DummyInternetTests
  class DummyInternetTest < Test::Unit::TestCase
    test "generates valid emails" do
      assert_match VALIDATE[:email], Dummy::Internet.email
    end

    test "generates valid user names" do
      assert_match VALIDATE[:username], Dummy::Internet.username
    end
    
    test "generates a valid password (MD5)" do
      assert_match VALIDATE[:password], Dummy::Internet.password
    end
    
    test "generates valid urls" do
      assert_match VALIDATE[:url], Dummy::Internet.url
    end
  end
end
