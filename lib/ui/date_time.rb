require "date"
require "time"

module UI
  class DateTime

    ZONES = {
      0  => ["UTC"],
      -4 => ["EDT"],
      -5 => ["EST", "CDT"],
      -6 => ["CST", "MDT"],
      -7 => ["PDT", "MST"],
      -8 => ["PST"]
    }

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