require "spec_helper"
require "thor"
require "rails/all"
require "genspec"

describe :gremlin do
  context "with no arguments or options" do
    it "should generate a help message" do
      subject.should output("A Help Message")
    end
  end

  context "with a name argument" do
    #with_args :users

    it "should generate a UsersController" do
      subject.should generate("app/controllers/users_controller.rb")
    end
  end
end
