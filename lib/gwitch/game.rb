# frozen_string_literal: true

require_relative "region"

module Gwitch
  class Game
    IdsExceedMaxError = Class.new(StandardError)

    MAX_IDS = 50

    class << self
      def all
        Region.games
      end

      def price(alpha2, ids, lang = 'en')
        raise IdsExceedMaxError if ids.is_a?(Array) && ids.size > MAX_IDS

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