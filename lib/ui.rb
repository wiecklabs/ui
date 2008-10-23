require "rubygems"

gem "wheels"
require "wheels"

Wheels::View::path << Pathname(__FILE__).dirname + "ui/views"

require Pathname(__FILE__).dirname.expand_path + "ui/pagination"
require Pathname(__FILE__).dirname.expand_path + "ui/calendar"