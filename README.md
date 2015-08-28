# Dummy

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://raw.githubusercontent.com/goncalossilva/dummy/master/LICENSE)
[![Build Status](https://travis-ci.org/goncalossilva/dummy.svg?branch=master)](https://travis-ci.org/goncalossilva/dummy)

[![Code Climate](https://codeclimate.com/github/goncalossilva/dummy/badges/gpa.svg)](https://codeclimate.com/github/goncalossilva/dummy)
[![Gem Version](https://badge.fury.io/rb/dummy.svg)](http://badge.fury.io/rb/dummy)
[![dummy Documentation](https://www.omniref.com/ruby/gems/dummy.png)](https://www.omniref.com/ruby/gems/dummy)

Dummy generates dummy data in a clever way.

It can generate a lot of dummy data from company names to postal codes.

While it allows you to specifically request a type of information,
it can also try to determine what you're looking for given a couple of parameters.


## Installation

```
$ gem install dummy
```

## Usage

To ask for cleverly generated dummy data:
```ruby
    Dummy.magic_data(field, type)
```

Example:
```ruby
    require "dummy"
    
    Dummy.magic_data("mail", :string) => "nyasia@hotmail.com"
    Dummy.magic_data("company_motto", :string) => "engineer intuitive functionalities"
    Dummy.magic_data("state", :string) => "Louisiana"
    Dummy.magic_data("lat", :float) => -86.718683637
    Dummy.magic_data("phone", :integer) => 9462876293
```

You can also use its submodules for specific data:
```ruby
    Dummy::Name.first_name => "Muhammad"
    Dummy::Internet.url => "https://david.grady.biz" 
    Dummy::Address.street_address => "10273 Delaney Extensions"
```

Have a look in the rdoc for all available generators.


## More information

### Caveats

Dummy has a few caveats which are on the TODO list.

Those are:

*   It is an English speaking gem. It will not be smart at all if your column is named _telefone_ (Portuguese for _phone_) or if you want a zip code from outside the US.

Copyright (c) 2010 Gonçalo Silva
