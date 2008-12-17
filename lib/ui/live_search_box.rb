module UI
  class LiveSearchBox
    def initialize(context, list_id)
      @context = context
      @list_id = list_id
    end

    def to_s
      Wheels::View.new("ui/live_search_box", @context.merge(:list_id => @list_id)).to_s
    end
  end
end