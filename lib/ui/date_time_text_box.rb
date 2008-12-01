module UI
  class DateTimeTextBox
    def initialize(object, name, field, options = {})
       @object = object
       @name = name
       @field = field
       options[:offset] ||= Time.now.gmt_offset / 60 / 60
       options[:shortcuts] ||= {}
       @options = options
    end

    def to_s
      context = @options.merge({ :object => @object, :name => @name, :field => @field })
      Wheels::View.new("ui/date_time_text_box.html.erb", context).to_s
    end
  end
end