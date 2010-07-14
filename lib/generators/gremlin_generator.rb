require 'rails/generators'
require 'rubygems'
require 'gremlin'
require 'active_support'

class GremlinGenerator < Rails::Generators::Base
  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end
  class_option :base_record_amount, :type => :numeric, :default => 10,
              :desc => "The base amount of records to generate for each model. Depending on associations, the generated value may vary depending on the specified base amount."
  
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
    get_table_names
    gather_associations
    predict_record_amounts
    generate_and_write_data
  end
  
  def get_table_names
    @models = Hash.new
    Dir["app/models/*.rb"].each do |full_path|
      model = File.basename(full_path).chomp(File.extname(full_path)).camelcase.constantize
      @models.merge!({model => {
        :record_amount => 0, :associations => []
      }}) if model.respond_to?(:columns)
    end
  end
  
  def gather_associations
    @models.each_key do |model|
      associations = model.reflect_on_all_associations(:belongs_to)
      
      associations.each do |association|
        if association.options.empty?
          name = association.name.to_s
          
          @models[model][:associations].push({
            :class_name  => name.camelcase,
            :foreign_key => "#{name}_id"
          })
        elsif association.options.has_key?(:class_name)
          @models[model][:associations].push(association.options)
        end
      end
      
    end
  end
  
  def predict_record_amounts
    models = @models.dup
    models.each do |model, info|
      predict_record_amount(model, info, models, [])
    end
  end
  
  def predict_record_amount(model, info, models, stacked_models)
    info[:associations].each do |association|
      assoc_model = association[:class_name].constantize
      
      if model != assoc_model and not stacked_models.include?(assoc_model)      
        stacked_models << assoc_model
        predict_record_amount(assoc_model, @models[assoc_model], models, stacked_models)
      end
    end
    
    if info[:associations].empty?
      @models[model][:record_amount] = options.base_record_amount
    else
      amount = info[:associations].map do |association|
        @models[association[:class_name].constantize][:record_amount]
      end.max*2
      
      @models[model][:record_amount] = amount
    end
    stacked_models.delete(model)
    models.delete(model)
  end
  
  def generate_and_write_data
    empty_directory "test/gremlin"
    
    @models.each do |model, info|
      name = model.to_s.underscore
      file = File.new("test/gremlin/#{name}.yml","w")
      
      (0..info[:record_amount]).each do |num|
        key_value = Hash.new
        fixture_data = Hash.new
        
        model.columns.each do |column|
          key_value = generate_record_data(name, info, column)
          fixture_data.merge!(key_value) unless key_value.nil?
        end
        
        fixture = { "#{name}_#{num}" => fixture_data }
        YAML.dump(fixture, file)
      end
      say_status :successful, "data generation for '#{name}'"
      file.close
    end
  end
  
  def generate_record_data(name, info, column)
    if (column.name =~ /_at$/ and column.type == :datetime) or column.name == "id"
      return
    end
  
    associated_model = associated_class_name(info, column.name)
    
    if associated_model
      val = generate_association_data(associated_model)
		else
			val = generate_regular_data(column)
    end
    
		{column.name => val}
  end
  
  def associated_class_name(info, name)
    info[:associations].each do |association|
      return association[:class_name] if association[:foreign_key] == name
    end
    false
  end
  
  def generate_association_data(associated_model)
    random_record_num = rand(@models[associated_model.constantize][:record_amount])
		"#{associated_model.to_s.underscore}_#{random_record_num}"
  end
  
  def generate_regular_data(column)
    case column.type
			when :string then
				case (1 + rand(3))
					when 1 then	
						val = Gremlin::Name.name
					when 2 then
						val = Gremlin::Lorem.sentence
					when 3 then
						val = Gremlin::PhoneNumber.phone_number
				end
			when :text then 
				val = Gremlin::Lorem.paragraph
			when :integer then
				val = rand(1000)
			when :date, :datetime then
				val = Date.today.to_s
			when :decimal, :float then
				val = rand(50).to_s + "." + (1000+rand(2000)).to_s
			when :boolean then
			  val = rand(2)
			else
				say_status :failed, "data generation for '#{column.name}' with type '#{column.type.to_s.downcase}'", :red
		end
  end
  
  def copy_rake_file
    copy_file "benchmark.rake", "lib/tasks/benchmark.rake"
  end
end
