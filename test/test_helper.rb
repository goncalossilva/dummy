require "rubygems"
require "dummy"
require "generators/dummy_generator"
require "test/unit"
require "rails/all"
require "rails/generators"
require "rails/generators/test_case"

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails_test'))
  end
end

def create_test_application
  Rails::Generators::AppGenerator.start(["#{Rails.root}"])
  
  templates_dir = File.expand_path("generators/templates", File.dirname(__FILE__))
  %w(child parent grand_parent).each do |model|
    copy_file "#{templates_dir}/#{model}.rb", "#{Rails.root}/app/models/#{model}.rb"
  end
end

VALIDATE = {
  :zip_code => /^([0-9]{5}-[0-9]{4}|[0-9]{5})$/,
  :us_state => /^([A-Z][a-z ]+)+$/,
  :us_state_short => /^[A-Z]{2}$/,
  :street_name => /^[A-Z][a-z"]+ [A-Z][a-z]+$/,
  :street_address => /^\d+ [A-Z][a-z"]+ [A-Z][a-z]+$/,
  :geolocation => /^-?[0-9]{1,3}(\.[0-9]{1,9})?$/,
  :latitude_max => 9e10,
  :latitude_min => -9e10,
  :longitude_max => 1.8e11,
  :longitude_min => -9e11,
  :email => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
  :username => /^([^\s]+)$/i,
  :password => /\S{32}/,
  :url => /(http|https|ftp):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/i,
  :sentence => /^[A-Z][a-z]* ([a-z ]+){3} [a-z]+\.$/,
  :sentences => /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){3}$/,
  :paragraph => /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){9}$/,
  :paragraphs => /^([A-Z ]{1,2}[a-z]* ([a-z ]+){3} [a-z]+\.){27}$/,
  :single_name => /^[A-Z][a-z"]+$/,
  :name => /^[A-Za-z\. ]*([A-Z][a-z ]+){2}[A-Za-z\. ]*$/,
  :phone_number => /^(1-)?\(?\d{3}\)?[-\.\)]\d{3}[-\.]\d{4}( x\d{3,5})?$/,
  :phone_number_short => /^\d{3}-\d{3}-\d{4}$/
}
