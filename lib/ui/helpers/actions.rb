module UI
  module Helpers
    module Actions
    
      def actions(name = nil, &b)
        if name
          named_actions_captures[name] = capture(&b)
        else
          actions_captures << capture(&b)
        end
      end
    
      def write_actions
        captures = (actions_captures + named_actions_captures.values)
        if captures.empty?
          nil
        else
          Harbor::View.new("ui/actions.html.erb", merge(:actions_content => captures.join("\n"))).to_s
        end
      end
    
      private
      def actions_captures
        @actions_captures ||= []
      end
    
      def named_actions_captures
        @named_actions_captures ||= {}
      end
    
    end
  end
end

Harbor::ViewContext.send(:include, UI::Helpers::Actions)
