require "harbor/locale"

module UI
  
  class LocaleSelection
    
    attr_accessor :locales, :options, :selected_culture_code
    
    def initialize(selected_culture_code = nil, locales = Harbor::Locale::active_locales, options = {})
      @selected_culture_code = selected_culture_code
      @locales = locales
      @options = options
    end
    
    def to_s
      @to_s ||= Harbor::View.new("ui/locale_selection.html.erb", :locale_selection_data => self).to_s
    end
    
  end
  
end