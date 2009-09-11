module UI
  class EmbedLink

    def initialize(context, text)
      @context = context
      @text = text
    end

    def to_s
      @context.render("ui/embed_link.html.erb", :text => @text).to_s
    end

  end
end