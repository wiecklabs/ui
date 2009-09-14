module UI
  class EmbedLink

    def initialize(context, content, title=nil)
      @context = context
      @content = content
      @title = title
    end

    def to_s
      @context.render("ui/embed_link.html.erb", :content => @content, :title => @title).to_s
    end

  end
end