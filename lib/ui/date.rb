module UI
  class Date

    def initialize(object, name, field)
      @object = object
      @name = name
      @field = field
    end

    def to_s
      Harbor::View.new("ui/date.html.erb", :object => @object, :name => @name, :field => @field).to_s
    end
  end
end