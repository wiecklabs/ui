module UI
  class GraphicImage
    
    attr_accessor :context, :original_image, :placeholder_image, :width, :height, :show_placeholder, :post_url
   
    def initialize(context, original_image, placeholder_image, width, height, show_placeholder=true, post_url=nil)
      @context = context
      @original_image = original_image
      @placeholder_image = placeholder_image
      @width = width
      @height = height
      @show_placeholder = show_placeholder
      @post_url = post_url
    end
    
    def to_s
      @context.render("ui/graphic_image.html.erb", :data => self)
    end
    
  end
end