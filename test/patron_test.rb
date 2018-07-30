require './lib/patron'
require 'minitest/autorun'
require 'minitest/pride'

class PatronTest < Minitest::Test
  def setup
    @bob = Patron.new("Bob")
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_has_a_name
    assert_equal "Bob", @bob.name
  end

  def test_interests_are_empty_by_default
    assert_equal [], @bob.interests
  end

  def test_it_can_add_interests
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @bob.interests
  end
end
