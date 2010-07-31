require "rubygems"
require "dummy"
require "test/unit"
require "fileutils"
require "rails/all"
require "rails/generators"
require "rails/generators/test_case"
require "rails/generators/rails/app/app_generator"

APP_NAME = "dummy_rails_app"

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), "../tmp/#{APP_NAME}"))
  end
end

def create_test_application
  if not Object.const_defined?(APP_NAME.gsub(/\W/, "_").squeeze("_").camelize)
    prepare_destination
    Rails::Generators::AppGenerator.start(["#{Rails.root}"])
  
    templates_dir = File.expand_path("generators/templates", File.dirname(__FILE__))
    ["child", "parent", "grand_parent"].each do |model|
      copy_file "#{templates_dir}/#{model}.rb", "#{Rails.root}/app/models/#{model}.rb"
    end
  end
end

def clean_dummy
  FileUtils.rm_rf(["#{Rails.root}/test/dummy/", "#{Rails.root}/lib/tasks/dummy.rake"])
end

def clean_tmp
  FileUtils.rm_rf("tmp")
end

VALIDATE = {
  :zip_code => /^([0-9]{5}-?[0-9]{4}|[0-9]{5})$/,
  :us_state => /^([A-Z][a-z ]+)+$/,
  :us_state_short => /^[A-Z]{2}$/,
  :street_name => /^[A-Za-z' ]*[A-Z][a-z ]+$/,
  :street_address => /^\d+ [A-Za-z' ]*[A-Z][a-z ]+$/,
  :neighborhood => /^([A-Z][a-z \/-]+)+$/,
  :company_name => /^[A-Za-z\W ]+$/,
  :company_catch_phrase => /^([a-z0-9\-',\/ ]+)+$/i,
  :company_bs => /^([a-z0-9\-',\/ ]+)+$/i,
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
  :single_name => /^[A-Za-z' ]*[A-Z][a-z ]+$/,
  :name => /^[A-Za-z\. ]*([A-Z][a-z' ]+){2}[A-Za-z\. ]*$/,
  :phone_number => /^(1-)?\(?\d{3}\)?[-\.\)]\d{3}[-\.]\d{4}( x\d{3,5})?$/,
  :phone_number_short => /^\d{3}-?\d{3}-?\d{4}$/
}

MAGIC_GENERATION = {
  :zip_code             => {:types => [:string, :integer],
                            :names => ["zip", "zip_code", "postal", "postal_code"]},
  :us_state             => {:types => [:string], 
                            :names => ["state", "us_state"]},
  :us_state_short       => {:types => [:string], 
                            :names => ["short_state", "state_abbreviation", "abbr_state", "state_small"]},
  :street_name          => {:types => [:string],
                            :names => ["street_name", "my_street", "name_of_street", "road", "awesome_road"]},
  :street_address       => {:types => [:string], 
                            :names => ["home_address", "user_residence", "dummy_residency"]},
  :neighborhood         => {:types => [:string], 
                            :names => ["neighbourhood", "neighborhood", "cool_district", "awesome_vinicity"]},
  :company_name         => {:types => [:string],
                            :names => ["company_name", "enterprise_designation", "business"]},
  :company_catch_phrase => {:types => [:string],
                            :names => ["company_motto", "company_description", "company_punchline",
                                       "enterprise_lemma", "enterprise_slogan", "enterprise_motto",
                                       "business_motto", "business_line", "firm_desc", "firm_punchline",
                                       "school_lemma", "college_description", "college_lemma"]},
  :company_bs           => {:types => [:string],
                            :names => ["company_other", "company_somethingelse",
                                       "enterprise_other", "enterprise_somethingelse",
                                       "business_somethingelse", "business_other", 
                                       "firm_somethingelse", "firm_other",
                                       "school_somethingelse", "college_other"]},
  :geolocation          => {:types => [:string, :float],
                            :names => ["latitude", "lat", "geo_lat", "longitude", "lon", "lng", "geo_lon", "geo_lng"]},
  :email                => {:types => [:string],
                            :names => ["mail", "email", "personal_mail", "company_email"]},
  :username             => {:types => [:string],
                            :names => ["username", "user", "usrname", "usr", "login"]},
  :password             => {:types => [:string],
                            :names => ["password", "pass", "hashed_pwd"]},
  :url                  => {:types => [:string],
                            :names => ["website", "personal_page", "twitter_page",
                                       "homepage", "user_url", "awesome_link", "href"]},
  :single_name          => {:types => [:string],
                            :names => ["first_name", "initial_name", "primary_name",
                                       "last_name", "surname", "latter_name", "awesome_family_name"]},
  :name                 => {:types => [:string],
                            :names => ["name", "awesome_name", "spy_name"]},
  :phone_number         => {:types => [:string],
                            :names => ["phone", "company_phone", "personal_phone"]},
  :phone_number_short   => {:types => [:string, :integer],
                            :names => ["short_phone", "phone_abbr", "phone_small", "phone_abbreviation"]}
}
