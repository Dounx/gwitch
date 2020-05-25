# frozen_string_literal: true

require "open-uri"
require "json"

module Gwitch
  class Region
    class Asia
      API_URL = 'https://search.nintendo.jp/nintendo_soft/search.json'
      QUERIES = {
        opt_sshow: 1,
        opt_osale: 1,
        opt_hard: '1_HAC',
        limit: 300
      }.freeze

      class << self
        def games
          games = []
          uri = URI.parse(API_URL)
          page = 1

          loop do
            uri.query = URI.encode_www_form(QUERIES.merge(page: page))

            result = JSON.parse(uri.read)['result']

            total = result['total']
            games += result['items']
            page += 1

            break unless games.size < total
          end

          parse(games)
        end

        private

        def parse(raw)
          host = 'https://ec.nintendo.com/JP/ja/titles/'
          image_host = 'https://img-eshop.cdn.nintendo.net/i/'
          image_extension = '.jpg'

          raw.map do |game|
            modes = []
            modes += game['pmode']&.map { |mode| mode.delete_suffix('_MODE') } || []

            image_urls = []
            image_urls += game['sslurl']&.map { |id| image_host + id + image_extension } if game['sslurl']
            image_urls << image_host + game['iurl'] + image_extension if game['iurl']

            url = game['nsuid'] ? host + game['nsuid'] : nil

            {
              nsuid: game['nsuid'],
              code: game['icode'],
              title: game['title'],
              description: game['text'],
              categories: game['genre'],
              maker: game['maker'],
              player: game['player']&.first,
              languages: game['lang'],
              modes: modes,
              dlcs: game['cnsuid'] || [],
              region: 'Asia',
              images: image_urls,
              url: url,
              release_at: game['pdate']
            }
          end
        end
      end
    end
  end
end