# frozen_string_literal: true

require 'bigdecimal'

module Finance
  # Returns prices and other data related to public stocks
  class Stock
    def initialize(prices: nil)
      @prices = prices
    end

    # TODO: This is a mock method to complete the Portfolio class
    def price(date:)
      BigDecimal(@prices[date.to_s].to_s)
    end
  end
end
