module UI
  class DateTimeTextBox
    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
      options[:offset] ||= Time.now.gmt_offset / 60 / 60
      options[:shortcuts] ||= {}
      @options = options
    end

    def to_s
      @context.render("ui/date_time_text_box.html.erb", { :object => @object, :name => @name, :field => @field }).to_s
    end
  end
end