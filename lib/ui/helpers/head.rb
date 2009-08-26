module UI
  module Helpers
    module Head
      def head(name = nil, &b)
        if name
          named_head_captures[name] = capture(&b)
        else
          head_captures << capture(&b)
        end
      end

      def write_head
        (head_captures + named_head_captures.values).join("\n")
      end

      private
      def head_captures
        @head_captures ||= []
      end

      def named_head_captures
        @named_head_captures ||= {}
      end
    end
  end
end

Harbor::ViewContext.send(:include, UI::Helpers::Head)