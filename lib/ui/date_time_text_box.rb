module UI
  class DateTimeTextBox
    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
      @offset = options.fetch(:offset, Time.now.gmt_offset / 60 / 60)
      @shortcuts = options.fetch(:shortcuts, {})
    end

    def to_s
      @context.render("ui/date_time_text_box.html.erb", { :object => @object, :name => @name, :field => @field, :offset => @offset, :shortcuts => @shortcuts }).to_s
    end
  end
end