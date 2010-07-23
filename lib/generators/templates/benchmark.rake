require 'active_record/fixtures'

namespace :dummy do
  namespace :data do
    desc "Load the generated dummy data into the current environment's database (default: \"dummy\")."
    task :import => :environment do
      Fixtures.reset_cache
      fixtures_folder = File.join(Rails.root, 'test', 'dummy')
      fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
      Fixtures.create_fixtures(fixtures_folder, fixtures)
    end
  end
end
