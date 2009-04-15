require "pathname"

module UI
  require Pathname(__FILE__).dirname + "color"

  class ColorPicker
    Asset::register("javascripts/color_picker.js", UI::asset_path + "javascripts/color_picker.js")

    def initialize(context, name, value = "#ffffff")
      @context = context
      @name = name
      @value = value
    end

    def to_s
      @context.render("ui/color_picker.html.erb", { :name => @name, :value => @value }).to_s
    end
  end
end