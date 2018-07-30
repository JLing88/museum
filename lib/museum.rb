require './lib/patron'
require 'pry'

class Museum
  attr_reader :name,
              :exhibits,
              :revenue,
              :exhibit_attendees

  def initialize(name)
    @name = name
    @exhibits = Hash.new(0)
    @revenue = 0
    @exhibit_attendees = Hash.new { |hash, key| hash[key] = [] }
  end

  def add_exhibit(exhibit, cost)
    @exhibits[exhibit] = cost
  end

  def admit(patron)
    @revenue += 10
    @exhibits.each do |exhibit, cost|
      @revenue += cost if patron.interests.include?(exhibit)
      record_attendance(patron, exhibit)
    end
  end

  def record_attendance(patron, exhibit)
    patron.interests.each do |interest|
      if interest == exhibit
        @exhibit_attendees[exhibit] << patron.name
      end
    end
  end

  def patrons_of(exhibit)
    @exhibit_attendees[exhibit]
  end

  def exhibits_by_attendees
    sorted_by_attendees = @exhibit_attendees.sort_by do |exhibit, attendees|
      attendees.length * -1
    end
    sorted_exhibits = sorted_by_attendees.map do |element|
      element[0]
    end
    sorted_exhibits
  end

  def remove_unpopular_exhibits(threshold)
    @exhibit_attendees.map do |exhibit, attendees|
      if attendees.length < threshold
        @exhibits.delete(exhibit)
      end
    end
    @exhibits
  end
end
