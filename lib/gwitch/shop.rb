# frozen_string_literal: true

require_relative 'shop/americas'
require_relative 'shop/asia'
require_relative 'shop/europe'

module Gwitch
  
  # Get all games from americas, asia and europe eshops.
  class Shop
    def self.games
      [Americas, Asia, Europe].map(&:games)
    end
  end
end