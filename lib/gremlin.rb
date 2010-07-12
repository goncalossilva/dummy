require 'rubygems'
require 'gremlin/address'
require 'gremlin/company'
require 'gremlin/internet'
require 'gremlin/lorem'
require 'gremlin/name'
require 'gremlin/phone_number'
require 'gremlin/geolocation'

module Gremlin
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
