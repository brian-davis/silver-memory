class RestaurantImporter
  class << self
    # RestaurantImporter.import! takes an attributes hash built
    # from JSON such as in db/seeds.json, and creates model records,
    # mapping to internal model and attribute names.
    def import!(data)
      Rails.logger.tagged("IMPORT").info { "START RestaurantImporter.import!" }
      results = {
        restaurant: {
          success: 0,
          failure: 0
        },
        menu: {
          success: 0,
          failure: 0
        },
        menu_item: {
          success: 0,
          failure: 0
        }
      }
      data["restaurants"].each do |restaurant_data|
        next unless restaurant_data["name"].present?
        Rails.logger.tagged("IMPORT").info { "importing restaurant: #{restaurant_data["name"]}" }

        restaurant = Restaurant.create!({ "name" => restaurant_data["name"] })
        results[:restaurant][:success] += 1

        if restaurant_data["menus"]
          restaurant_data["menus"].each do |menu_data|
            next unless menu_data["name"].present?

            Rails.logger.tagged("IMPORT").info { "importing menu: #{menu_data["name"]}" }
            menu = Menu.create!({ restaurant: restaurant, name: menu_data["name"] })
            results[:menu][:success] += 1

            (menu_data["menu_items"].presence || menu_data["dishes"].presence || []).each do |menu_item|
              next unless menu_item["name"].present? && menu_item["price"].present?
              Rails.logger.tagged("IMPORT").info { "importing menu_item: #{menu_data["name"]} #{menu_data["price"]}" }

              menu_item = MenuItem.find_or_create_by!({
                name: menu_item["name"],
                price: menu_item["price"]
              })
              results[:menu_item][:success] += 1
              menu.menu_items << menu_item
            rescue => e
              results[:menu_item][:failure] += 1
              Rails.logger.tagged("IMPORT").error { e.message }
            end

          rescue => e
            results[:menu][:failure] += 1
            Rails.logger.tagged("IMPORT").error { e.message }
          end
        end
        

      rescue => e
        results[:restaurant][:failure] += 1
        Rails.logger.tagged("IMPORT").error { e.message }
      end
      Rails.logger.tagged("IMPORT").info { "END RestaurantImporter.import! #{results}" }
      return results
    end
  end
end