module UI
  class DateTimeTextBox
    def initiailize(object, name, field, offset = (Time.local.gmt_offset / 60 / 60))
       @object = object
       @name = name
       @field = field
       @offset = offset
    end

    def to_s
      context = { :object => @object, :name => @name, :field => @field, :offset => @offset }
      Wheels::View.new("ui/date_time_text_box.html.erb", context).to_s
    end
  end
end