module UI
  class RichTextArea
    Asset.register("javascripts/tiny_mce", UI::asset_path + "javascripts/tiny_mce")
    
    def initialize(context, name, width="500", height="100", existing_value="", element_id=nil, preset=nil)
      @context = context
      @width = width
      @height = height
      @element_id = element_id
      @name = name
      @existing_value = existing_value
      @preset = preset
    end
    
    def to_s
      @context.render("ui/rich_text_area.html.erb", :width => @width, :height => @height, :name => @name, :existing_value => @existing_value, :element_id => @element_id, :preset => @preset).to_s
    end
    
  end
end