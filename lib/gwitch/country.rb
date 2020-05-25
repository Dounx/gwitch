# frozen_string_literal: true

require "countries"
require_relative "game"

module Gwitch
  class Country
    InvaildAlpha2CodeError = Class.new(StandardError)

    class << self
      # All avaliable countries
      def all
        countries = ISO3166::Country.all.map do |country|
          Country.new(country.alpha2)
        end

        countries.select{ |country| country.avaliable? }
      end
    end

    def initialize(alpha2)
      @country = ISO3166::Country[alpha2]
      raise InvaildAlpha2CodeError unless @country
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

    def avaliable?
      # An americas game
      nsuid = '70010000000141'
      
      !Game.price(alpha2, nsuid).nil?
    end
  end
end