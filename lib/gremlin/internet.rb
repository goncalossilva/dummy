module Gremlin
  module Internet

    def email
      [ user_name(name), domain_name ].join('@')
    end

    def free_email
      "#{user_name(name)}@#{HOSTS.rand}"
    end

    def user_name
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

    def domain_name
      "#{domain_word}.#{domain_suffix}"
    end

    def domain_word
      dw = Company.name.split(' ').first
      dw.gsub!(/\W/, '')
      dw.downcase!
      dw
    end

    def domain_suffix
      DOMAIN_SUFFIXES.rand
    end

    HOSTS = %w(gmail.com yahoo.com hotmail.com)
    DOMAIN_SUFFIXES = %w(co.uk com us uk ca biz info name)
  end
end
