require "pathname"
require Pathname(__FILE__).dirname + "test_helper"

class CalendarTest < Test::Unit::TestCase

  def test_month_succ    
    assert_equal UI::Calendar::Month.new(2008, 11), UI::Calendar::Month.new(2008, 10).succ
    assert_equal UI::Calendar::Month.new(2009, 1), UI::Calendar::Month.new(2008, 12).succ
  end

  def test_month_compare
    assert_equal -1, (UI::Calendar::Month.new(2008, 10) <=> UI::Calendar::Month.new(2008, 11))
    assert_equal 1, (UI::Calendar::Month.new(2009, 1) <=> UI::Calendar::Month.new(2008, 12))
  end

  def test_month_range
    assert_equal 4, (UI::Calendar::Month.new(2008, 10)..UI::Calendar::Month.new(2009, 1)).to_a.size
  end

  def test_to_s
    assert_equal "October 2008", UI::Calendar::Month.new(2008, 10).to_s
  end

end