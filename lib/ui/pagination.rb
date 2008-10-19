View::path << Pathname(__FILE__).dirname + "views"

module UI
  class Pagination
    
    def initialize(page_size, total_count, selected_page)
      @page_size = page_size
      @total_count = total_count
      @selected_page = selected_page
    end
    
    def to_s
      View.new("ui/pagination.html.erb", :page_size => @page_size, :total_count => @total_count, :selected_page => @selected_page).to_s
    end
  end
end