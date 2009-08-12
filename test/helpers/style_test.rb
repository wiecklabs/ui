require "pathname"
require Pathname(__FILE__).dirname.parent + "test_helper"
require Pathname(__FILE__).dirname.parent.parent + "lib/ui/helpers/style"

class StyleTest < Test::Unit::TestCase

  include UI::Helpers::Style

  def test_stripe_within_loop
    (0..4).each do |i|
      intended_value = (i % 2 == 0) ? "first" : "second"
      assert_equal intended_value, stripe("first", "second")
    end
  end

  def test_stripe_doesnt_pollute
    assert_equal "first", stripe("first", "second")
    assert_equal "first", stripe("first", "second")
  end

end