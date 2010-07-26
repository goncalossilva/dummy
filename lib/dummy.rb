require "rubygems"
require "dummy/address"
require "dummy/company"
require "dummy/internet"
require "dummy/lorem"
require "dummy/name"
require "dummy/phone_number"
require "dummy/geolocation"
require "generators/dummy_generator"

module Dummy
  extend self

  def numerify(number_string)
    number_string.gsub(/#/) { rand(10).to_s }
  end

  def letterify(letter_string)
    letter_string.gsub(/\?/) { ("a".."z").to_a.rand }
  end

  def bothify(string)
    letterify(numerify(string))
  end
  
  def magic_data(field, type)
    case type
    when :string, :text then magic_string(field, type)
    when :integer then magic_integer(field)
    when :date, :datetime then magic_date(field)
    when :decimal, :float then magic_float(field)
    when :boolean then rand(2)
    else false
    end
  end
  
  def magic_string(field, type=:string)
    case field
    when /name/ then
      case field.gsub(/name/, "")
      when /company|enterprise|business|firm/ then
        Dummy::Company.name
      when /street|road/ then
        Dummy::Address.street_name
      when /neighbou?rhood|neighbou?rship|district|vicinity/ then
        Dummy::Address.neighborhood
      when /first|initial|primary/ then
        Dummy::Name.first_name
      when /last|latter|family|sur/ then
        Dummy::Name.last_name
      when /user|usr|login/ then
        Dummy::Internet.username
      else
        Dummy::Name.name
      end
    when /login|user|usr/ then
      Dummy::Internet.username
    when /state/ then
      case field.gsub(/state/, "")
      when /short|abbreviation|abbr|small/ then
        Dummy::Address.us_state_short
      else
        Dummy::Address.us_state
      end
    when /zip|postal/ then
      Dummy::Address.zip_code
    when /city|town/ then
      Dummy::Address.city
    when /address|residence|residency/ then
      Dummy::Address.street_address
    when /company|enterprise|business|firm/ then
      case field.gsub(/company|enterprise|business|firm/, "")
      when /motto|description|slogan|lemma|punch|line/ then
        Dummy::Company.catch_phrase
      else
        Dummy::Company.bs
      end
    when /^lat/ then
      Dummy::Geolocation.lat
    when /^lon|^lng/ then
      Dummy::Geolocation.lng
    when /mail/ then
      Dummy::Internet.email
    when /password|pwd/ then
      Dummy::Internet.password
    when /phone/ then
      case field.gsub(/phone/, "")
      when /short|abbreviation|abbr|small/ then
        Dummy::PhoneNumber.short_phone_number
      else
        Dummy::PhoneNumber.phone_number
      end
    else
      case type
      when :string then
        case rand(2)
        when 0 then Dummy::Lorem.sentence
        when 1 then Dummy::Lorem.sentences
        end
      when :text then
        case rand(2)
        when 0 then Dummy::Lorem.paragraph
        when 1 then Dummy::Lorem.paragraphs
        end
      end
    end 
  end
  
  def magic_integer(field)
    rand(1000)
  end
  
  def magic_date(field)
    Date.today.to_s
  end
  
  def magic_float(field)
    val = rand(50).to_s + "." + (1000+rand(2000)).to_s
  end
end

class Array
  def rand
    self[super(self.length)]
  end
end

