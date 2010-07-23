require "spec_helper"

describe Dummy::Internet do
  it "generates valid emails" do
    Dummy::Internet.email.should match /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  end

  it "generates valid user names" do
    Dummy::Internet.user_name.should match /^([^\s]+)$/i
  end
end
