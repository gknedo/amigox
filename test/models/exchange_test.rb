require 'test_helper'

class ExchangeTest < ActiveSupport::TestCase
  def setup
    @exchange = Exchange.new(admins: [1],participants: [1,2,3,4,5],raffle: 14.days.from_now)
  end

  test "should be valid" do
    valid_exchange = Exchange.new(admins: [1],participants: [1,2,3,4,5],raffle: 14.days.from_now)
    assert valid_exchange.valid?

    valid_exchange = Exchange.new(admins: [1,2,3,4,5],participants: [1,2,3,4,5])
    assert valid_exchange.valid?

    invalid_exchange = Exchange.new
    assert_not invalid_exchange.valid?

    valid_exchange = Exchange.new(participants: [1,2,3,4,5])
    assert_not valid_exchange.valid?
  end
end
