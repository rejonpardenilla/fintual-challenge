# frozen_string_literal: true

require_relative '../../lib/finance/portfolio'
require_relative '../../lib/finance/stock'
require_relative '../spec_helper'

describe Finance::Portfolio do
  context 'instance' do
    it 'should have a profit method' do
      portfolio = Finance::Portfolio.new
      expect(portfolio).to respond_to(:profit)
    end

    it 'should return a profit between two valid dates' do
      from_date = Date.new(2021, 10, 10)
      to_date = Date.new(2021, 11, 10)
      stocks = [
        Finance::Stock.new(
          prices: {
            from_date.to_s => 10,
            to_date.to_s => 11
          }
        ),
        Finance::Stock.new(
          prices: {
            from_date.to_s => 10,
            to_date.to_s => 11
          }
        )
      ]
      portfolio = Finance::Portfolio.new(stocks)
      profit = portfolio.profit(from: from_date, to: to_date)
      expect(profit).to be_a(Numeric)
      expect(profit).to eq(2)
    end
  end

  it 'should return a loss (or negative profit) between two dates' do
    from_date = Date.new(2021, 10, 10)
    to_date = Date.new(2021, 11, 10)
    stocks = [
      Finance::Stock.new(
        prices: {
          from_date.to_s => 10,
          to_date.to_s => 9
        }
      ),
      Finance::Stock.new(
        prices: {
          from_date.to_s => 10,
          to_date.to_s => 9
        }
      )
    ]
    portfolio = Finance::Portfolio.new(stocks)
    profit = portfolio.profit(from: from_date, to: to_date)
    expect(profit).to be_a(Numeric)
    expect(profit).to eq(-2)
  end

  it 'should return the right number with decimal prices between two dates' do
    from_date = Date.new(2021, 10, 10)
    to_date = Date.new(2021, 11, 10)
    stocks = [
      Finance::Stock.new(
        prices: {
          from_date.to_s => 10.1,
          to_date.to_s => 11.2
        }
      ),
      Finance::Stock.new(
        prices: {
          from_date.to_s => 10.1,
          to_date.to_s => 11.2
        }
      )
    ]
    portfolio = Finance::Portfolio.new(stocks)
    profit = portfolio.profit(from: from_date, to: to_date)
    expect(profit).to be_a(BigDecimal)
    expect(profit).to eq(2.2)
  end
end
