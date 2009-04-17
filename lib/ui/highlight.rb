require "pathname"

module UI

  class Highlight
    Asset::register("javascripts/ui.core.js", UI::asset_path + "javascripts/ui.core.js")
    Asset::register("javascripts/effects.core.js", UI::asset_path + "javascripts/effects.core.js")
    Asset::register("javascripts/effects.highlight.js", UI::asset_path + "javascripts/effects.highlight.js")

    def initialize(context, css_class_name, value, color, speed = 3000)
      @context = context
      @css_class_name = css_class_name.sub(/^\./, "")
      @value = value
      @color = color
      @speed = speed
    end

    def to_s
      @context.render("ui/highlight.html.erb", { :css_class_name => @css_class_name, :value => @value, :color => @color, :speed => @speed }).to_s
    end
  end
end