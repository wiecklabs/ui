require "wheels"

Wheels::View::path << Pathname(__FILE__).dirname + "ui/views"

require "ui/pagination"
require "ui/calendar"