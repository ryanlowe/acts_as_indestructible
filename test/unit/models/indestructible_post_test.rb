require File.dirname(__FILE__) + '/../../test_helper'

class IndestructiblePostTest < ActiveSupport::TestCase
  fixtures :indestructible_posts
  
  def test_fixtures
    assert indestructible_posts(:destroyed).valid?
    assert indestructible_posts(:hello).valid?
    assert indestructible_posts(:goodbye).valid?
    assert indestructible_posts(:no_body).valid?
  end
  
end
