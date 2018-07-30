require './lib/museum'
require './lib/patron'
require 'minitest/autorun'
require 'minitest/pride'

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_a_name
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_it_can_add_exhibits
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    assert_equal ({"Dead Sea Scrolls" => 10, "Gems and Minerals" => 0}), @dmns.exhibits
  end

  def test_it_can_admit_patrons

  end

  def test_it_can_calculate_revenue
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")

    @dmns.revenue

    assert_equal 0, @dmns.revenue

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal 40, @dmns.revenue
  end

  def test_it_can_return_the_patrons_of_and_exhibit
    @dmns.add_exhibit("Dead Sea Scrolls", 10)

    bob = Patron.new("Bob")
    bob.add_interest("Dead Sea Scrolls")

    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal [bob.name, sally.name], @dmns.patrons_of("Dead Sea Scrolls")
  end

  def test_it_can_record_attendance
    @dmns.add_exhibit("Dead Sea Scrolls", 10)

    bob = Patron.new("Bob")
    bob.add_interest("Dead Sea Scrolls")

    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")

    @dmns.record_attendance(bob, "Dead Sea Scrolls")
    @dmns.record_attendance(sally, "Dead Sea Scrolls")

    assert_equal ({"Dead Sea Scrolls" => ["Bob", "Sally"]}), @dmns.exhibit_attendees
  end

  def test_it_can_record_and_sort_exhibits_by_number_of_attendees
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @dmns.exhibits_by_attendees
  end

  def test_it_can_remove_unpopular_exhibits
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal @dmns.exhibits, @dmns.remove_unpopular_exhibits(2)
  end
end
