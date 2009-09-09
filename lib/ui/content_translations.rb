module UI
  
  class ContentTranslations
  
    attr_accessor :content_type
    attr_accessor :default_translation, :translations
  
    def initialize(content_type, default_translation, translations)
      @content_type = content_type
      @default_translation = default_translation
      @translations = translations
      
      if @translations.nil?
        raise Error.new("UI::ContentTranslations requires a non-nil collection of translations")
      end
    end
  
    def to_s
      @to_s ||= Harbor::View.new("ui/content_translations.html.erb", :data => self).to_s
    end
  
  end
    
end