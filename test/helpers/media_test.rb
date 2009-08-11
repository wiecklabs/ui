require "pathname"
require Pathname(__FILE__).dirname.parent + "test_helper"
require Pathname(__FILE__).dirname.parent.parent + "lib/ui/helpers/media"

class MediaTest < Test::Unit::TestCase

  include UI::Helpers::Media

  def test_normalize_file_extension_with_simple_case
    assert_equal "JPG", normalize_file_extension(".jpg")
  end

  def test_normalize_file_extension_is_nil_safe
    assert_nil normalize_file_extension(nil)
  end

  def test_normalize_file_extension_terminates_on_blank_string
    assert_nil normalize_file_extension("")
  end

  def test_normalize_file_extension_accepts_extension_without_leading_period
    assert_equal "JPG", normalize_file_extension("jpg")
  end

  def test_bytes_to_human_size
    assert_equal "0.9 KB", bytes_to_human_size(876)
    assert_equal "8.6 KB", bytes_to_human_size(8760)
    assert_equal "85.5 KB", bytes_to_human_size(87600)
    assert_equal "0.1 MB", bytes_to_human_size(104858)
    assert_equal "0.8 MB", bytes_to_human_size(876000)
  end

end