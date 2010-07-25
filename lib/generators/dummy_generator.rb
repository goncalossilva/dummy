require "yaml"
require "active_support"
require "active_record"
require "rails/generators"

module Dummy
  class DataGenerator < Rails::Generators::Base
    def self.source_root
      @source_root ||= File.expand_path("../templates", __FILE__)
    end
    class_option :base_amount, :type => :numeric, :default => 10,
                :desc => "The base amount of records to generate for each model."
    class_option :growth_ratio, :type => :numeric, :default => 2.0,
                :desc => "The growth ratio of each model, according to its associations."

    def install_dummy
      initialize_application
      generate_dummy_data
      copy_rake_file
    end

    private

    def initialize_application
      require File.expand_path("#{Rails.root}/config/environment.rb")
      say_status :successful, "Initialize Rails application"
    end

    def generate_dummy_data
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
        model_symbol = model.to_s.underscore.pluralize.to_sym
        associations = model.reflect_on_all_associations(:belongs_to)

        associations.each do |assoc|
          assoc_name = assoc.name.to_s.camelcase
          assoc_options = assoc.options

          if assoc_options.empty?
            @models[model][:associations].push({
              :model  => assoc_name.constantize,
              :foreign_key => "#{assoc_name.underscore}_id"
            })
          elsif assoc_options.has_key?(:class_name) and assoc_options.has_key?(:foreign_key)
            @models[model][:associations].push({
              :model => assoc_options[:class_name].constantize, #TODO class_name
              :foreign_key => assoc_options[:foreign_key]
            })
          else
            next
          end

          assoc_model = @models[model][:associations].last[:model]
          assoc_reflections = assoc_model.reflect_on_all_associations(:has_many)
          @models[model][:associations].pop if assoc_reflections.map(&:name).include?(model_symbol)
        end
      end
    end

    def predict_record_amounts
      models = @models.dup
      models.each do |model, info|
        predict_record_amount(model, info, models, [])
        remove_if_subclass(model)
      end
    end

    def predict_record_amount(model, info, models, stacked_models)
      info[:associations].each do |assoc|
        next if stacked_models.include?(assoc[:model])

        if model != assoc[:model]
          stacked_models << assoc[:model]
          predict_record_amount(assoc[:model], @models[assoc[:model]], models, stacked_models)
        end
      end

      amount = options.base_amount
      if not info[:associations].empty?
        amount = info[:associations].map do |assoc|
          @models[assoc[:model]][:record_amount]
        end.max*options.growth_ratio # **info[:associations].size
      end

      @models[model][:record_amount] += amount.to_i
      stacked_models.delete(model)
      models.delete(model)
    end

    def remove_if_subclass(model)
      if @models.keys.include?(model.superclass)
        @models[model.superclass][:record_amount] += @models[model][:record_amount]
        @models.delete(model)
      end
    end

    def generate_and_write_data
      empty_directory "test/dummy"

      @models.each do |model, info|
        fixtures = Hash.new
        name = model.to_s.underscore
        file = File.new("test/dummy/#{model.table_name}.yml","w")

        file.write("# #{model.to_s} data generated automatically by dummy (#{info[:record_amount]} records).\n")

        (0..info[:record_amount]-1).each do |num|
          key_value = Hash.new
          fixture_data = Hash.new

          model.columns.each do |column|
            key_value = generate_record_data(name, info, column)
            fixture_data.merge!(key_value) unless key_value.nil?
          end

          fixtures.merge!({ "#{name}_#{num}" => fixture_data })
        end

        YAML.dump(fixtures, file)
        file.close
        say_status :successful, "Generate #{info[:record_amount]} records for '#{name}'"
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
      info[:associations].each do |assoc|
        return assoc[:model] if assoc[:foreign_key] == name
      end
      false
    end

    def generate_association_data(associated_model)
      random_record_num = rand(@models[associated_model][:record_amount])
	    "#{associated_model.to_s.underscore}_#{random_record_num}"
    end

    def generate_regular_data(column)
      case column.type
		    when :string then
			    case (1 + rand(3))
				    when 1 then
					    val = Dummy::Name.name
				    when 2 then
					    val = Dummy::Lorem.sentence
				    when 3 then
					    val = Dummy::PhoneNumber.phone_number
			    end
		    when :text then
			    val = Dummy::Lorem.paragraph
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
end

