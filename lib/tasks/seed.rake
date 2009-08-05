namespace :db do
  desc "Load seed fixtures (from db/fixtures) into the current evnironment's database."
  task :seed => :environment do
    require 'active_record/fixtures'
    Dir.glob(RAILS_ROOT + '/db/fixtures/*.yml').each do |file|
      print "loading #{file}...."
      Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
      print "complete!\n"
    end
    
    Dir.glob(RAILS_ROOT + '/db/fixtures/*.rb').each do |file|
      print "loading #{file}...."
      load file
      print "complete!\n"
    end
  end
end
