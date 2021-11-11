# frozen_string_literal: true

require 'date'

module Finance
  # Keeps track of your stock profits
  class Portfolio
    def initialize(stocks = [])
      @stocks = stocks
    end

    def profit(from:, to:)
      @stocks.reduce(0) do |sum, stock|
        initial_price = stock.price(date: from)
        last_price = stock.price(date: to)
        sum += last_price - initial_price
      end
    end
  end
end
