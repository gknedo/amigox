require 'test_helper'
require File.expand_path('../../../app/helpers/exchanges_helper.rb', __FILE__)

class ExchangesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @ex_one = exchanges(:one)
    @ex_two= exchanges(:two)
  end
end