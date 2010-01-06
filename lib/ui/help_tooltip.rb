module UI
  class HelpTooltip
    def initialize(context, text)
      @context = context
      @text = text
    end

    def to_s
      @context.render("ui/help_tooltip", :text => @text)
    end
  end
end