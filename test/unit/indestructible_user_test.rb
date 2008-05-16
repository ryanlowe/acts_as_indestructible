require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :indestructible_users
  
  def test_fixtures
    assert indestructible_users(:ryanlowe).valid?
    assert indestructible_users(:tigerwoods).valid?
  end
end
