require "cgi"

module UI
  class Clipboard
    def initialize(context, content)
      @context = context
      @content = CGI.escape(content)
    end

    def to_s
      @context.render "ui/clipboard", :content => @content
    end
  end
end