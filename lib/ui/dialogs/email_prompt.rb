module UI

  module Dialogs

    class EmailPrompt
      
      def initialize(context, url)
        @context = context
        @url = url
      end

      def to_s
        @context.render("ui/dialogs/email_prompt.html.erb", { :url => @url }).to_s
      end

    end

  end

end
