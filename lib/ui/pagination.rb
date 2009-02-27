module UI
  class Pagination

    attr_reader :page_size, :total_count, :selected_page, :pages

    def initialize(context, page_size, total_count, selected_page)
      @context = context
      @page_size = page_size.to_i
      @total_count = total_count.to_i
      @selected_page = selected_page.to_i

      if @total_count == 0
        @pages = [1]
      else
        @pages = (1..(@total_count.to_f / @page_size).ceil)
      end

      raise ArgumentError.new("The selected_page must start at 1. The selected_page provided was #{selected_page.blank? ? 'none' : selected_page}") if @selected_page.blank?
      raise ArgumentError.new("The selected_page (#{selected_page}) can't be larger than the max pages present (#{@pages.max}).") if @selected_page > @pages.max
    end

    def to_s
      @to_s ||= Wheels::View.new("ui/pagination.html.erb", @context.merge(:pagination => self)).to_s
    end
  end
end