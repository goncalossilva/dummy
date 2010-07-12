class GremlinGenerator < Rails::Generator::Base
  source_root File.expand_path('../templates', __FILE__)
  
  def install_gremlin
    copy_rake_file
    generate_gremlin_data
  end

  private
  
  def copy_rake_file
    copy_file "benchmark.rake", "lib/tasks/benchmark.rake"
  end
  
  def generate_gremlin_data
    puts "haha"
  end
end
