module Wheels
  class ViewContext
    
    def actions(name = nil, &b)
      if name
        named_actions_captures[name] = capture(&b)
      else
        actions_captures << capture(&b)
      end
    end
    
    def write_actions      
      View.new("ui/actions.html.erb", merge(:actions_content => (actions_captures + named_actions_captures.values).join("\n"))).to_s
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