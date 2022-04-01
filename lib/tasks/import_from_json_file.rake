namespace :data do
  desc 'Read JSON from a file, parse as an attributes hash for importing'
  # restaurantapp $ bundle exec rake data:import_from_json_file[db/seeds.json]
  task :import_from_json_file, [:filename] => [:environment] do |t, args|
    if File.exist?(args[:filename])
      Rails.logger.tagged("RAKE").tagged("IMPORT").info { "START IMPORT FROM FILE:#{args[:filename]}" }
      json_string = File.read(args[:filename])
      data = JSON.parse(json_string)
      RestaurantImporter.import!(data)
    else 
      abort('File not found.')
    end
  rescue JSON::ParserError => e
    abort("Invalid JSON")
  end
end