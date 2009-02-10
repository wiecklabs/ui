module UI
  class DateTextBox

    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
    end

    def to_s
      @context.render("ui/date_text_box.html.erb", { :object => @object, :name => @name, :field => @field }).to_s
    end
  end
end