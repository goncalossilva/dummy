require 'rubygems'
require 'gremlin/address'
require 'gremlin/internet'
require 'gremlin/lorem'
require 'gremlin/name'
require 'gremlin/phone_number'
require 'gremlin/geolocation'

module Gremlin

  def self.numerify(number_string)
    number_string.gsub!(/#/) { rand(10).to_s }
    number_string
  end

  def self.letterify(letter_string)
    letter_string.gsub!(/\?/) { ('a'..'z').rand }
    letter_string
  end

  def self.bothify(string)
    letterify(numerify(string))
  end
end

module Array
  def rand
    self[super(self.length)]
  end
end
