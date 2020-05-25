# frozen_string_literal: true

require "optparse"
require_relative "version"

module Gwitch
  class CLI
    attr_reader :options

    def parse(args = ARGV)
      @options = setup_options(args)
    end

    private

    def setup_options(args)
      # parse CLI options
      parse_options(args)
    end

    def parse_options(argv)
      opts = {}
      parser = option_parser(opts)
      parser.parse!(argv)
      opts
    end

    def option_parser(opts)
      parser = OptionParser.new { |o|
        o.on "-g", "--games", "Get all games (without price info)" do |arg|
          opts[:game] = arg
        end

        o.on "-p", "--price alpha2,nsuid1,nsuid2", Array, "Get games' price (Max 50 nsuids)" do |arg|
          opts[:price] = arg
        end

        o.on "-c", "--countries", "Get avaliable countries' alpha2 code" do |arg|
          opts[:country] = arg
        end

        o.on "-v", "--version", "Print version and exit" do |arg|
          puts "Gwitch #{VERSION}"
          exit 0
        end
      }

      parser.banner = "Usage: gwitch [options]"
      parser.on_tail "-h", "--help", "Show help" do
        puts parser
        exit 1
      end

      parser
    end
  end
end