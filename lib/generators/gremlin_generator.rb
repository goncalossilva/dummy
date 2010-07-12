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
    output_status("Initializing the application") do
      require File.expand_path("config/environment.rb")
    end
  end
  
  def generate_gremlin_data
    Dir["app/models/*.rb"].each do |full_path|
      mh = Hash.new
		  ma = Hash.new
		  mf = Hash.new
		
      name = File.basename(full_path).chomp(File.extname(full_path))
      
      output_status("Generating data for '#{name}'") do
        begin
          eval(name.camelcase).columns.each do |column|
            generate_record_data(name, column, mh, ma, mf)
          #puts name.camelcase + " => " + column.name + " ("+column.type.to_s.downcase+")"
          end
        rescue NoMethodError
        end
        mf.merge!(name => {"fields" => ma})
		    mf[name].merge!({"quantity" => 10})
		    File.open("test/gremlin/" + "%03d" % eval(name.camelcase).reflections.count + "-" + name  + ".yml","w") do |out|
			    YAML.dump(mf,out)
	      end
      end
    end 
  end
  
  def generate_record_data(name, column, mh, ma, mf)
    if column.name.include? "_id" then
			vl = "@" + column.name.sub("_id","").pluralize + "[rand(@" + column.name.sub('_id','').pluralize + ".length)][1]"
			mh = {column.name => vl}
			ma.merge!(mh)
		else
			case column.type.to_s.downcase
				when 'string'
					case (1 + rand(3))
						when 1					
							vl = Gremlin::Name.name
						when 2
							vl = Gremlin::Lorem.words
						when 3 
							vl = Gremlin::Lorem.sentence
						when 4 
							vl = Gremlin::PhoneNumber.phone_number
					end
				when 'text' then 
					vl = Gremlin::Lorem.paragraph
				when 'integer' then
					vl = rand(1000)
				when 'datetime' 
					vl = Date.today.to_s
				when 'date'
					vl = Date.today.to_s
				when 'decimal' then
					vl = rand(50).to_s + "." + (1000+rand(2000)).to_s
				else
					puts "=-------=============> " + column.type.to_s.downcase
			end
			if not column.name.include? "_at" and :include_special	
				mh = {column.name => vl}
				ma.merge!(mh)
			end
		end
  end
  
  def copy_rake_file
    output_status("Copying the rake file") do
      copy_file "benchmark.rake", "lib/tasks/benchmark.rake"
    end
  end
  
  def output_status(message)
    print "#{message}... "
    begin
      yield
      puts "OK"
    rescue Exception => e
      puts "#{e}"
      puts "Aborted!"
      Process.exit
    end
  end
end
