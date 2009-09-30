module UI
  class Pagination

    attr_reader :page_size, :total_count, :selected_page, :pages, :previous_text, :next_text

    def initialize(context, page_size, total_count, selected_page, previous_text = "Previous", next_text = "Next")
      @context = context
      @page_size = page_size.to_i
      @total_count = total_count.to_i
      @selected_page = selected_page.to_i
      @previous_text = previous_text
      @next_text = next_text

      if @total_count == 0
        @pages = [1]
      else
        @pages = (1..(@total_count.to_f / @page_size).ceil).to_a
      end

      raise ArgumentError.new("The selected_page must start at 1. The selected_page provided was #{selected_page.blank? ? 'none' : selected_page}") if @selected_page.blank?
      raise ArgumentError.new("The selected_page (#{selected_page}) can't be larger than the max pages present (#{@pages.max}).") if @selected_page > @pages.max
    end

    def page_context
      start = (@selected_page < 3 ? 1 : @selected_page - 2) - 1
      @pages[start, 5]
    end

    def to_s(format = "default", action = nil, container = nil)
      @to_s ||= Harbor::View.new("ui/pagination/#{format}.html.erb", @context.merge(:pagination => self, :action => action, :container => container)).to_s.gsub("\n",'').gsub("\"", '\'')
    end
  end
end