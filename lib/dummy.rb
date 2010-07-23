require 'rubygems'
require 'dummy/address'
require 'dummy/company'
require 'dummy/internet'
require 'dummy/lorem'
require 'dummy/name'
require 'dummy/phone_number'
require 'dummy/geolocation'

module Dummy
  extend self
  
  def numerify(number_string)
    number_string.gsub(/#/) { rand(10).to_s }
  end

  def letterify(letter_string)
    letter_string.gsub(/\?/) { ('a'..'z').to_a.rand }
  end

  def bothify(string)
    letterify(numerify(string))
  end
end

class Array
  def rand
    self[super(self.length)]
  end
end
