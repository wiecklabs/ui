module UI
  class DateTime

    def initialize(object, name, field)
      @object = object
      @name = name
      @field = field
    end

    def to_s
      Wheels::View.new("ui/date_time.html.erb", :object => @object, :name => @name, :field => @field).to_s
    end
  end
end