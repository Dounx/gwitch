# frozen_string_literal: true

require_relative "region"

module Gwitch
  class Game
    IdsExceedMaxError = Class.new(StandardError)

    class << self
      # Get all game or one of them
      def all(area = nil)
        case area
        when 'Americas'
          Region::Americas.games
        when 'Asia'
          Region::Asia.games
        when 'Europe'
          Region::Europe.games
        else
          Region.games
        end
      end

      # ids can be String or Array
      def price(alpha2, ids, lang = 'en')
        raise IdsExceedMaxError if ids.is_a?(Array) && ids.size > 50

        api_url = 'https://api.ec.nintendo.com/v1/price'
        queries = {
          country: alpha2,
          lang: lang,
          ids: ids
        }

        uri = URI.parse(api_url)
        uri.query = URI.encode_www_form(queries)

        JSON.parse(uri.read)
      rescue OpenURI::HTTPError
        nil
      end
    end
  end
end