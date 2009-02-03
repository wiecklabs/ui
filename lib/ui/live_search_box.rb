module UI
  class LiveSearchBox
    def initialize(context, list_id, callback = nil)
      @context = context
      @list_id = list_id
      @callback = callback
    end

    def to_s
      @context.render "ui/live_search_box", :list_id => @list_id, :callback => @callback
    end
  end
end