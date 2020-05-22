# frozen_string_literal: true

require "open-uri"
require "json"

module Gwitch
  class Region

    # A class which get games from europe eshop.
    class Europe
      RowsTooSmallError = Class.new(StandardError)

      API_URL = 'https://search.nintendo-europe.com/en/select'
      MAX_ROWS = 100000

      # ((playable_on_txt:"HAC")) means platform is nintendo switch
      QUERIES = {
        q: '*',
        fq: '((playable_on_txt:"HAC"))',
        wt: 'json',
        rows: MAX_ROWS,
        start: 0
      }.freeze

      class << self
        # Get all games from asia eshop.
        def games
          uri = URI.parse(API_URL)
          uri.query = URI.encode_www_form(QUERIES)
          response = JSON.parse(uri.read)['response']

          raise RowsTooSmallError if response['numFound'] > MAX_ROWS

          parse(response['docs'])
        end

        private

        def parse(raw)
          host = 'https://www.nintendo.co.uk'
          schema = 'https:'

          raw.map do |game|
            code = game['product_code_txt']&.first
            code = code[4..8] if code

            modes = []
            modes << 'TV' if game['play_mode_tv_mode_b']
            modes << 'TABLETOP' if game['play_mode_tabletop_mode_b']
            modes << 'HANDHELD' if game['play_mode_handheld_mode_b']

            url = game['url'] ? host + game['url'] : nil

            {
              nsuid: game['nsuid_txt'] || [],
              code: code,
              title: game['title'],
              description: game['excerpt'],
              categories: game['pretty_game_categories_txt'] || [],
              maker: game['publisher'],
              player: game['players_to'],
              languages: game['language_availability']&.first&.split(',') || [],
              modes: modes,
              cloud_save: game['cloud_saves_b'],
              images: [
                schema + game['image_url'],
                schema + game['image_url_sq_s'],
                schema + game['image_url_h2x1_s'],
                schema + game['gift_finder_carousel_image_url_s'],
                schema + game['gift_finder_detail_page_image_url_s'],
                schema + game['gift_finder_wishlist_image_url_s'],
                schema + game['wishlist_email_square_image_url_s'],
                schema + game['wishlist_email_banner460w_image_url_s'],
                schema + game['wishlist_email_banner640w_image_url_s']
              ],
              url: url,
              release_at: game['dates_released_dts']&.first
            }
          end
        end
      end
    end
  end
end