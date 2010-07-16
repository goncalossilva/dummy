require "spec_helper"

describe Gremlin::Internet do
  it "generates valid emails" do
    Gremlin::Internet.email.should match /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  end

  it "generates valid user names" do
    Gremlin::Internet.user_name.should match /^([^\s]+)$/i
  end
end
