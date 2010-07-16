require 'active_record/fixtures'

namespace :gremlin do
  namespace :data do
    desc "Load the generated gremlin data into the current environment's database (default: \"gremlin\")."
    task :import => [:environment, "db:migrate"] do
      Fixtures.reset_cache
      fixtures_folder = File.join(Rails.root, 'test', 'gremlin')
      fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
      Fixtures.create_fixtures(fixtures_folder, fixtures)
    end
  end
end
