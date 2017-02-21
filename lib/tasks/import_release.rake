namespace :import_release do
  task start: :environment do
    puts "Importing Latest Release...\n"
    ImportRelease.perform
    puts "Importing Complete\n"
  end

end
