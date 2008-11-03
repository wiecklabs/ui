module UI
  class Toolbar

    def self.links
      @links ||= {}
    end
    
    def self.register(title, action, url)
      links[title] << [action, url]
    end
    
    attr_reader :name
    
    def initialize(context, name)
      @context = context
      @name = name
    end

    def to_s
      @to_s ||= Wheels::View.new("ui/toolbar.html.erb", @context.merge(:toolbar => self)).to_s
    end
  end
end