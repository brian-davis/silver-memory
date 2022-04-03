Rails.logger.tagged("RAKE").tagged("SEED").info { "START IMPORT FROM seeds.json" }
json_string = File.read(Rails.root.join("db", "seeds.json"))
data = JSON.parse(json_string)
RestaurantImporter.import!(data)