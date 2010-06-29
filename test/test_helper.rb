require "rubygems"
require "pathname"
require "test/unit"
require "mocha"

require Pathname(__FILE__).dirname.parent + "lib/ui"

UI::public_path = Pathname(__FILE__).dirname + ".." + "tmp" + "public"
