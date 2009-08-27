module UI
  
  class DateRangeSelection
    
    attr_accessor :context, :options
    
    def initialize(context, options = {})
      @context = context
      @options = options

      # Set up the range of selectable dates.
      @options[:start_date] ||= ::Date.parse('1970-1-1')
      @options[:end_date] ||= ::Date.today

      # Set up the initially selected range.
      @options[:selected_start_date] ||= ::Date.today - 30 
      @options[:selected_end_date] ||= ::Date.today

      @options[:label] ||= "Timeframe:"
    end
    
    def to_s
      @to_s ||= Harbor::View.new("ui/date_range_selection.html.erb", @options.merge({ :context => @context })).to_s
    end
    
  end
  
end
