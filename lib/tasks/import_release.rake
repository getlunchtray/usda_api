namespace :import_release do
  task start: :environment do
    puts "Importing Latest Release...\n"
    ImportRelease.new.perform
    puts "Importing Complete\n"
  end

end
