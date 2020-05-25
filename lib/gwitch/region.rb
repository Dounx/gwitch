# frozen_string_literal: true

require_relative "region/americas"
require_relative "region/asia"
require_relative "region/europe"

module Gwitch
  
  # Get all games from americas, asia and europe eshops
  class Region
    def self.games
      games = {}
      threads = 
        [Americas, Asia, Europe].map do |region|
          Thread.new do
            games[region.name.split('::').last] = region.games
          end
        end
      threads.each(&:join)
      games
    end
  end
end