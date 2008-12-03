module Wheels
  class ViewContext
    
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