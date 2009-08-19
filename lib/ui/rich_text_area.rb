module UI
  class RichTextArea
    Asset.register("javascripts/tiny_mce", UI::asset_path + "javascripts/tiny_mce")
    attr_accessor :advanced, :options
    
    def initialize(context, width="500", height="100", element_id=nil)
      @context = context
      @width = width
      @height = height
      @element_id = element_id
    end
    
    def to_s
      @context.render("ui/rich_text_area.html.erb", :width => @width, :height => @height, :element_id => @element_id)
    end
    
  end
end