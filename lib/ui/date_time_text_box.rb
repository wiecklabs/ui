module UI
  class DateTimeTextBox

    def self.default_offset=(offset)
      @default_offset = offset
    end

    def self.default_offset
      @default_offset || (Time.now.gmt_offset / 60 / 60)
    end

    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
      @offset = options.fetch(:offset, self.class.default_offset)
      @shortcuts = options.fetch(:shortcuts, {})
    end

    def to_s
      @context.render("ui/date_time_text_box.html.erb", { :object => @object, :name => @name, :field => @field, :offset => @offset, :shortcuts => @shortcuts }).to_s
    end
  end
end