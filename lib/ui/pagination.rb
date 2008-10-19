View::path << Pathname(__FILE__).dirname + "views"

module UI
  class Pagination
    
    attr_reader :page_size, :total_count, :selected_page, :pages
    
    def initialize(page_size, total_count, selected_page)
      @page_size = page_size.to_i
      @total_count = total_count.to_i
      @selected_page = selected_page.to_i
      
      @pages = (1..(@total_count.to_f / @page_size).ceil)
      
      raise ArgumentError.new("The selected_page must start at 1. The selected_page provided was #{selected_page.blank? ? 'none' : selected_page}") if @selected_page == 0
      raise ArgumentError.new("The selected_page (#{selected_page}) can't be larger than the max pages present (#{@pages.max}).") if @selected_page > @pages.max
    end
    
    def to_s
      @to_s ||= View.new("ui/pagination.html.erb", :pagination => self).to_s
    end
  end
end