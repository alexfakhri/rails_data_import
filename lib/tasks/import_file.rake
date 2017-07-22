namespace :import_file do
  desc "Imports text file to DB"
  task :import, [:file] => [:environment] do |t, args|
    LogFileImporter.new(args[:file]).run
  end
end
