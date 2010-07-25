require 'active_record/fixtures'

namespace :dummy do
  namespace :data do
    desc "Load the generated dummy data into the current environment's database."
    task :import => :environment do
      ENV['FIXTURES_PATH'] = File.join(Rails.root, 'test', 'dummy')
      Rake::Task["db:fixtures:load"].invoke
    end
  end
end
