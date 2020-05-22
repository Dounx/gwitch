# frozen_string_literal: true

require "countries"
require_relative "game"

module Gwitch
  class Country
    class << self
      # All avaliable countries
      def all
        ISO3166::Country.all.map(&:alpha2).select do |alpha2|
          avaliable?(alpha2)
        end.map { |alpha2| Country.new(alpha2) }
      end

      def avaliable?(alpha2)
        # An americas game
        nsuid = '70010000000141'
        
        !Game.price(alpha2, nsuid).nil?
      end
    end

    def initialize(alpha2)
      @country = ISO3166::Country[alpha2]
    end

    def alpha2
      @country.alpha2
    end

    def region
      @country.region
    end

    def currency
      @country.currency_code
    end
  end
end