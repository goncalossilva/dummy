require "spec_helper"

describe Dummy::PhoneNumber do
  it "generates a valid phone number" do
    Dummy::PhoneNumber.phone_number.should match /^(1-)?\(?\d{3}\)?[-\.\)]\d{3}[-\.]\d{4}( x\d{3,5})?$/
  end
  
  it "generates a valid short phone number" do
    Dummy::PhoneNumber.short_phone_number.should match /^\d{3}-\d{3}-\d{4}$/
  end
end
