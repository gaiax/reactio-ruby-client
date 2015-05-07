module Reactio
  module Utils
    NIL_STRING = 'null'.freeze

    def to_option_string(symbol)
      return NIL_STRING if symbol.nil?
      symbol.to_s.gsub('_', '-')
    end
  end
end
