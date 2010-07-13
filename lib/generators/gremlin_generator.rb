require 'rails/generators'
require 'rubygems'
require 'gremlin'

class GremlinGenerator < Rails::Generators::Base
  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end
  
  def install_gremlin
    initialize_application
    generate_gremlin_data
    copy_rake_file
  end

  private
  
  def initialize_application
    require File.expand_path("config/environment.rb")
    say_status :successful, "Rails application initialize"
  end
  
  def generate_gremlin_data
    Dir["app/models/*.rb"].each do |full_path|
      name = File.basename(full_path).chomp(File.extname(full_path))
      file = File.new("test/gremlin/#{name}.yml","w")
  
      (0..10).each do |num|
        key_value = Hash.new
        fixture_data = Hash.new
        
        begin
          eval(name.camelcase).columns.each do |column|
            key_value = generate_record_data(name, column)
            fixture_data.merge!(key_value) unless key_value.nil?
          end
        rescue NoMethodError => e
          puts "#{e}" # TODO: remove
        end
        
        fixture = { "#{name}_#{num}" => fixture_data }
        YAML.dump(fixture, file)
      end
      say_status :successful, "data generation for '#{name}'"
      file.close
    end 
  end
  
  def generate_record_data(name, column)
    # Journal.reflect_on_all_associations(:belongs_to).count => 3 # FIXME
    if column.name.include? "_id" then
			val = "@" + column.name.sub("_id","").pluralize + "[rand(@" + column.name.sub('_id','').pluralize + ".length)][1]"
		else
			case column.type.to_s.downcase
				when 'string' then
					case (1 + rand(3))
						when 1 then	
							val = Gremlin::Name.name
						when 2 then
							val = Gremlin::Lorem.sentence
						when 3 then
							val = Gremlin::PhoneNumber.phone_number
					end
				when 'text' then 
					val = Gremlin::Lorem.paragraph
				when 'integer' then
					val = rand(1000)
				when 'datetime' then
					val = Date.today.to_s
				when 'date' then
					val = Date.today.to_s
				when 'decimal' then
					val = rand(50).to_s + "." + (1000+rand(2000)).to_s
				when 'boolean' then
				  val = rand(2)
				else
					say_status :failed, "data generation for '#{column.name}' with type '#{column.type.to_s.downcase}'", :red
			end
    end
    if not column.name.include? "_at"	
			{column.name => val}
		end
  end
  
  def copy_rake_file
    copy_file "benchmark.rake", "lib/tasks/benchmark.rake"
  end
end
