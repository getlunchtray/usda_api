namespace :import_release do
  task start: :environment do
    ImportRelease.perform
  end

end
