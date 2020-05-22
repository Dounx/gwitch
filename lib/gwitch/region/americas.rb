# frozen_string_literal: true

require "algoliasearch"

module Gwitch
  class Region

    # A class which get games from americas eshop.
    class Americas
      CLIENT = Algolia::Client.new(
        application_id: 'U3B6GR4UA3',
        api_key: '9a20c93440cf63cf1a7008d75f7438bf'
      )

      INDEX = CLIENT.init_index('noa_aem_game_en_us')

      PLATFORM = 'platform:Nintendo Switch'

      # Trick for API limitation.
      # Nintendo limit each facet can only get 1000 results.
      # So we use as much as possible to get results.
      # Maybe incompletely got.
      # DON'T use this directly.
      # Use filters method.
      FACETS = { 
        generalFilters: ['Deals', 'DLC available', 'Demo available', 'Online Play via Nintendo Switch Online', 'Nintendo Switch Game Voucher'],
        availability: ['New releases', 'Available now', 'Pre-purchase', 'Coming soon'],
        categories: ['Action', 'Adventure', 'Application', 'Education', 'Fitness', 'Indie', 'Music', 'Party', 'Puzzle', 'Racing', 'Role-Playing', 'Simulation', 'Sports', 'Strategy'],
        filterShops: ['At retail', 'On Nintendo.com'],
        virtualConsole: ['NES', 'Super NES', 'Game Boy', 'Game Boy Color', 'Nintendo 64', 'Game Boy Advance', 'Nintendo DS', 'Other'],
        characters: ['Mario', 'Zelda', 'Donkey Kong', 'Metroid', 'Pokémon', 'Mii', 'Kirby', 'Animal Crossing'],
        priceRange: ['Free to start', '$0 - $4.99', '$5 - $9.99', '$10 - $19.99', '$20 - $39.99', '$40+'],
        esrb: ['Everyone', 'Everyone 10+', 'Teen', 'Mature'],
        filterPlayers: ['1+', '2+', '3+', '4+']
      }.freeze

      class << self
        def games
          games = []

          # No facets
          games += fetch

          # Each facet
          filters.each do |filter|
            games += fetch(filter)
          end

          parse(games.uniq)
        end

        private

        def fetch(filter = nil)
          hits = []
        
          # Empty string means all
          query = ''
        
          # histPerPage max can be 500
          search_params = {
            hitsPerPage: 500
          }
        
          search_params.merge!(facetFilters: filter) if filter
        
          page = 0
        
          loop do
            response = INDEX.search(query, search_params.merge(page: page))
            total_pages = response['nbPages']
            hits += response['hits']
            page += 1

            break unless page < total_pages
          end
        
          hits
        end

        # GalleryParsedError = Class.new

        def parse(raw)
          host = 'https://www.nintendo.com'
          microsite_host = 'https://assets.nintendo.com/image/upload/f_auto,q_auto,w_960,h_540'
          legacy_host = 'https://assets.nintendo.com/video/upload/f_auto,q_auto,w_960,h_540'
          asset_host = 'https://assets.nintendo.com/image/upload/f_auto,q_auto,w_960,h_540/Legacy%20Videos/posters/'

          raw.map do |game|
            image_urls = []
            image_urls << (host + game['boxArt']) if game['boxArt']

            gallery_path = game['gallery']
            if gallery_path.nil?
              nil
            # Begin with '/'
            elsif gallery_path[0] == '/'
              # If prefix is 'content'
              if gallery_path[1] == 'c'
                image_urls << host + gallery_path
              # Prefix is 'Microsites'
              # Just one game
              elsif  gallery_path[1] == 'M'
                url = microsite_host + gallery_path
                last_slash = url.rindex('/')
                image_urls << url.insert(last_slash + 1, 'posters/')
              # Prefix is 'Nintendo'
              elsif gallery_path[1] == 'N'
                # TODO Nintendo* url have many situations
                # https://assets.nintendo.com/image/upload/f_auto,q_auto,w_960,h_540/Nintendo Switch/Games/Third Party/Overcooked 2/Video/posters/Overcooked_2_Gourmet_Edition_Trailer
                # /Nintendo Switch/Games/Third Party/Overcooked 2/Video/Overcooked_2_Gourmet_Edition_Trailer

                # https://assets.nintendo.com/video/upload/f_auto,q_auto,w_960,h_540/Nintendo Switch/Games/NES and Super NES/Video/NES_Super_NES_May_2020_Game_Updates_Nintendo_Switch_Online
                # /Nintendo Switch/Games/NES and Super NES/Video/NES_Super_NES_May_2020_Game_Updates_Nintendo_Switch_Online
              # Prefix is 'Legacy Videos'
              elsif gallery_path[1] == 'L'
                image_urls << legacy_host + gallery_path
              else
                raise GalleryParsedError
              end
            # Just id
            else
              image_urls << asset_host + gallery_path
            end

            url = game['url'] ? host + game['url'] : nil

            {
              nsuid: game['nsuid'],
              title: game['title'],
              description: game['description'],
              categories: game['categories'],
              maker: game['publishers']&.join(', '),
              player: game['players'],
              images: image_urls,
              url: url,
              release_at: game['releaseDateMask']
            }
          end
        end

        def filters
          filters = []
          
          FACETS.each do |facet, options|
            options.each do |option|
              filters << [PLATFORM, "#{facet}:#{option}"]
            end
          end

          filters
        end
      end
    end
  end
end