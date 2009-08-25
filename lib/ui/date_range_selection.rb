module UI
  
  class DateRangeSelection
    
    attr_accessor :context, :options
    
    def initialize(context, options = {})
      @context = context
      @options = options

      options[:start_date] ||= Date.today - 30
      options[:end_date] ||= Date.today
    end
    
    def to_s
      @to_s ||= Harbor::View.new("ui/date_range_selection.html.erb", @options.merge({ :context => @context })).to_s
    end
    
  end
  
end
