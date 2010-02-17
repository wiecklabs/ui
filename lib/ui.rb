require "rubygems"

gem "harbor"
require "harbor"

module UI
  
  class Error < RuntimeError; end
  
end

Harbor::View::path << Pathname(__FILE__).dirname.expand_path + "ui/views"

require Pathname(__FILE__).dirname.expand_path + "ui/ui"

require Pathname(__FILE__).dirname.expand_path + "ui/account_navigation"
require Pathname(__FILE__).dirname.expand_path + "ui/asset"
require Pathname(__FILE__).dirname.expand_path + "ui/assets"
require Pathname(__FILE__).dirname.expand_path + "ui/badge"
require Pathname(__FILE__).dirname.expand_path + "ui/button"
require Pathname(__FILE__).dirname.expand_path + "ui/calendar"
require Pathname(__FILE__).dirname.expand_path + "ui/clipboard"
require Pathname(__FILE__).dirname.expand_path + "ui/color"
require Pathname(__FILE__).dirname.expand_path + "ui/color_picker"
require Pathname(__FILE__).dirname.expand_path + "ui/content_translations"
require Pathname(__FILE__).dirname.expand_path + "ui/date"
require Pathname(__FILE__).dirname.expand_path + "ui/date_range_selection"
require Pathname(__FILE__).dirname.expand_path + "ui/date_text_box"
require Pathname(__FILE__).dirname.expand_path + "ui/date_time"
require Pathname(__FILE__).dirname.expand_path + "ui/date_time_text_box"
require Pathname(__FILE__).dirname.expand_path + "ui/dialogs/email_prompt"
require Pathname(__FILE__).dirname.expand_path + "ui/embed_link"
require Pathname(__FILE__).dirname.expand_path + "ui/error_messages"
require Pathname(__FILE__).dirname.expand_path + "ui/file_upload"
require Pathname(__FILE__).dirname.expand_path + "ui/formatted_date"
require Pathname(__FILE__).dirname.expand_path + "ui/graphic_image"
require Pathname(__FILE__).dirname.expand_path + "ui/help_tooltip"
require Pathname(__FILE__).dirname.expand_path + "ui/helpers/actions"
require Pathname(__FILE__).dirname.expand_path + "ui/helpers/head"
require Pathname(__FILE__).dirname.expand_path + "ui/highlight"
require Pathname(__FILE__).dirname.expand_path + "ui/javascripts/default_inputs"
require Pathname(__FILE__).dirname.expand_path + "ui/live_search_box"
require Pathname(__FILE__).dirname.expand_path + "ui/locale_flag"
require Pathname(__FILE__).dirname.expand_path + "ui/locale_selection"
require Pathname(__FILE__).dirname.expand_path + "ui/mime_type_icon"
require Pathname(__FILE__).dirname.expand_path + "ui/pagination"
require Pathname(__FILE__).dirname.expand_path + "ui/rich_text_area"
require Pathname(__FILE__).dirname.expand_path + "ui/social_media"
require Pathname(__FILE__).dirname.expand_path + "ui/tag_box"
require Pathname(__FILE__).dirname.expand_path + "ui/toolbar"

UI::FormattedDate.register_format("rfc822", "%a, %d %b %Y %H:%M:%S %z")
