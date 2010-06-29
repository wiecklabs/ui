module UI

  module Helpers

    # Usage:
    #
    # Layout:
    #
    #   <% head.title_format "My Site - %s" %>
    #   <head>
    #     ...
    #     <%= write_head %>
    #   </head>
    #
    # View:
    #
    #   <% head.title "Content Show Page" %>
    #   <% head.keywords 'my', 'site', 'content', 'etc' %>
    #
    # =>
    #   <head>
    #     <title>My Site - Content Show Page</title>
    #     <meta name="keywords" content="my,site,content,etc" />
    #   </head>

    module Head

      # Capture the output of the block and either set the named value on the UI::Head or append it
      def head(name = nil, &block)
        @head ||= UI::Head.new
        if block_given?
          captured_output = capture(&block)
          name ? @head.set(name, captured_output) : @head.append(captured_output)
        else
          @head
        end
      end

      # Return UI::Head#to_html
      def write_head
        @head.to_html
      end

    end

  end

end

Harbor::ViewContext.send(:include, UI::Helpers::Head)
