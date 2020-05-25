# frozen_string_literal: true

require_relative "region/americas"
require_relative "region/asia"
require_relative "region/europe"

module Gwitch
  class Region
    def self.games
      semaphore = Mutex.new
      games = []

      threads = 
        [Americas, Asia, Europe].map do |region|
          Thread.new do
            semaphore.synchronize {
              games += region.games
            }
          end
        end
      threads.each(&:join)
      games
    end
  end
end