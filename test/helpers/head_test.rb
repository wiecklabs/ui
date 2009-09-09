require "pathname"
require Pathname(__FILE__).dirname.parent + "test_helper"

class HeadTest < Test::Unit::TestCase

  def setup
    Harbor::View.path << Pathname(__FILE__).dirname.parent + "views"
  end

  def teardown
    Harbor::View.path.clear
  end

  def test_head_is_handled_properly_in_view_context
    view = Harbor::View.new("partial")
    result = view.to_s("layout")
    assert_equal "HEAD\n\nCONTENT", result
  end
end