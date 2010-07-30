# Dummy

Dummy generates dummy data for your Rails 3 application and allows you to import it.

## Description

Dummy generates data for your application by inspecting your models and their associations. It tries to generate the correct type of data for each column by guessing what it is from its name. Finally, it allows you to import the generated data into the database.

## Installation

$ gem install dummy

## Usage

Add the following to the Gemfile of your Rails 3 application:
    gem "dummy"
    
Now you have access to the generator:
    rails generate dummy:data
    
You can also change the base amount of records and the growth ratio (what these mean exactly is explained latter on):
    rails generate dummy:data --base-amount=5 --growth-ratio=1.5
    
And you can manually define the amount of records to generate for each model (or just accept the defaults):
    rails generate dummy:data --manual-amounts
    
The fixtures are stored in _test/dummy/_ while a rake file is placed in _lib/tasks/dummy.rake_. It allows you to import the generated data into the database:
    RAILS_ENV="dummy" rake dummy:data:import

Don't forget to change RAILS_ENV to whatever is appropriate for you (and is configured under databases.yml). Your database doesn't need to be empty.

Another less conventional way of using dummy is to directly use its magic data generation:
    Dummy.magic_data(field, type)
    
Example:
    require "dummy"
    
    Dummy.magic_data("mail", :string) => "nyasia@hotmail.com"
    Dummy.magic_data("company_motto", :string) => "engineer intuitive functionalities"
    Dummy.magic_data("state", :string) => "Louisiana"
    Dummy.magic_data("lat", :float) => -86.718683637
    Dummy.magic_data("phone", :integer) => 9462876293


## More information

### Smart data

Dummy tries to understand your database columns and generates data accordingly, instead of dumping "Lorem ipsum" all over the place.

For instance, if you have a field called _company\_name_, it will generate a company name. If you have a field called _awesome\_postal\_code_, it will generate a valid ZIP Code. If you have a field called _longitude_, it will generate a valid longitude. And so on. You get the picture.

Dummy cares about associations. It will create random associations between the automatically generated records.

### Smart amounts of data

Dummy is aware that the amount of records that each model has in real world applications is different. For this reason, it will analyze your model associations to try to make a somewhat accurate estimation of the expected amount of records.

To illustrate this, consider an application with models for _Child_, _Parent_ and _GrandParent_. If the base amount is 10, the growth ratio is 2.0, and the models look like the following:

    class GrandParent < ActiveRecord::Base  
      has_many :parents
    end
    
    class Parent < ActiveRecord::Base
      belongs_to :grand_parent
      has_many :children
    end
    
    class Child < ActiveRecord::Base
        belongs_to :parent
    end`

The generator will create dummy data for 10 _GrandParents_, 20 _Parents_ and 40 _Children_.

### Caveats

Dummy has a few caveats which are on the TODO list. Those are:
* It is an English speaking gem. It will not be smart at all if your column is named _telefone_ (Portuguese for _phone_) or if you want a zip code from outside the US.
* It will generate valid emails, latitudes, street addresses, etc, but it doesn't care about your model validations.

Copyright (c) 2010 Gonçalo Silva
