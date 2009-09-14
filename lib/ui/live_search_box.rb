module UI
  class LiveSearchBox
    def initialize(context, list_id, callback = nil, live_search_class = nil)
      @context = context
      @list_id = list_id
      @callback = callback
      @live_search_class = live_search_class || "live_search"
    end

    def to_s
      @context.render "ui/live_search_box", :list_id => @list_id, :callback => @callback, :live_search_class => @live_search_class
    end
  end
end