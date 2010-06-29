require "pathname"
require Pathname(__FILE__).dirname.parent + "test_helper"

class HeadTest < Test::Unit::TestCase

  def setup
    Harbor::View.path << Pathname(__FILE__).dirname.parent + "views"
    @module = Object.new
    @module.extend(UI::Helpers::Head)
  end

  def teardown
    Harbor::View.path.clear
  end

  def test_head_is_handled_properly_in_view_context
    view = Harbor::View.new("partial")
    result = view.to_s("layout")
    assert_equal "HEAD\n\nCONTENT", result
  end

  def test_head_allows_title_setting
    @module.head.title('foo')
    assert_equal 'foo', @module.head.title
  end

  def test_setting_title_when_base_title_absent
    @module.head.title('foo')
    assert_equal "<title>foo</title>\n", @module.write_head
  end

  def test_setting_title_when_base_title_present
    @module.head.title_format('foo - %s')
    @module.head.title('bar')
    assert_equal "<title>foo - bar</title>\n", @module.write_head
  end

  def test_resetting_title_when_title_format_absent
    @module.head.title!('bar')
    assert_equal "<title>bar</title>\n", @module.write_head
  end

  def test_resetting_title_when_title_format_present
    @module.head.title_format('foo - %s')
    @module.head.title!('bar')
    assert_equal "<title>bar</title>\n", @module.write_head
  end

  def test_adding_keywords_one_at_a_time
    @module.head.keyword 'foo'
    @module.head.keyword 'bar'
    assert_equal "<meta name=\"keywords\" content=\"foo,bar\" />\n", @module.write_head
  end

  def test_adding_keywords_with_an_array
    @module.head.keywords ['foo', 'bar']
    assert_equal "<meta name=\"keywords\" content=\"foo,bar\" />\n", @module.write_head
  end

  def test_adding_keywords_with_var_args
    @module.head.keywords 'foo', 'bar'
    assert_equal "<meta name=\"keywords\" content=\"foo,bar\" />\n", @module.write_head
  end

  def test_duplicate_keywords_are_ignored
    @module.head.keywords 'foo', 'bar', 'bar', 'baz'
    assert_equal "<meta name=\"keywords\" content=\"foo,bar,baz\" />\n", @module.write_head
  end

end
