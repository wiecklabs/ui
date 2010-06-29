require "pathname"
require Pathname(__FILE__).dirname + "test_helper"

class LocaleFlagTest < Test::Unit::TestCase

  def setup

  end

  def test_unknown_is_returned_when_locale_is_not_found
    flag = UI::LocaleFlag.new("foo")
    assert_equal "/assets/images/locales/unknown.gif", flag.to_s
  end

  def test_with_locale_to_s
    flag = UI::LocaleFlag.new(Harbor::Locale["en-US"])
    assert_equal "/assets/images/locales/en-US.gif", flag.to_s
  end

  def test_with_string_to_s
    flag = UI::LocaleFlag.new("en-US")
    assert_equal "/assets/images/locales/en-US.gif", flag.to_s
  end

end
