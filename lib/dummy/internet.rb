require 'digest/md5'

module Dummy
  module Internet
    extend self
  
    def email
      "#{username}@#{HOSTS.rand}"
    end

    def username
      case rand(2)
      when 0
        Name.first_name.gsub(/\W/, '').downcase
      when 1
        parts = [ Name.first_name, Name.last_name ].each {|n| n.gsub!(/\W/, '') }
        parts = parts.join %w(. _)[Kernel.rand(2)].dup
        parts.downcase!
        parts
      end
    end
    
    def password
      Digest::MD5.hexdigest(Dummy::Lorem.sentence)
    end
    
    private

    HOSTS = %w(gmail.com yahoo.com hotmail.com)
  end
end
