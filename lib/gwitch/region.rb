# frozen_string_literal: true

require_relative "region/americas"
require_relative "region/asia"
require_relative "region/europe"

module Gwitch
  
  # Get all games from americas, asia and europe eshops
  class Region
    def self.games
      Hash[
        [Americas, Asia, Europe].collect do |region| 
          [region.name.split('::').last, region.games]
        end
      ]
    end
  end
end