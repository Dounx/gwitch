# frozen_string_literal: true

require_relative 'shop'

module Gwitch
  class Game
    class << self
      def all(area = nil)
        case area
        when :americas
          Shop::Americas.games
        when :asia
          Shop::Asia.games
        when :europe
          Shop::Europe.games
        else
          Shop.games
        end
      end

      def price(country, lang, ids)
        api_url = 'https://api.ec.nintendo.com/v1/price'
        queries = {
          country: country,
          lang: lang,
          ids: ids
        }

        uri = URI.parse(api_url)
        uri.query = URI.encode_www_form(queries)
        JSON.parse(uri.read)
      end
    end
  end
end