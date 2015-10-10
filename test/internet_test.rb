require_relative 'test_helper'

module DummyInternetTests
  class DummyInternetTest < Test::Unit::TestCase
    def test_valid_emails
      assert_match VALIDATE[:email], Dummy::Internet.email
    end

    def test_valid_user_names
      assert_match VALIDATE[:username], Dummy::Internet.username
    end

    def test_valid_password_MD5
      assert_match VALIDATE[:password], Dummy::Internet.password
    end

    def test_valid_urls
      assert_match VALIDATE[:url], Dummy::Internet.url
    end
  end
end
