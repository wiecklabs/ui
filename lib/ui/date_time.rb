require "date"
require "time"

module UI
  class DateTime

    ZONES = {
      0  => ["UTC"],
      -4 => ["EDT"],
      -5 => ["EST"],
      -6 => ["CST"],
      -7 => ["MST"],
      -8 => ["PST"],
      +11 => ["EDT"]
    }

    def initialize(object, name, field)
      @object = object
      @name = name
      @field = field
    end

    def to_s
      Harbor::View.new("ui/date_time.html.erb", :object => @object, :name => @name, :field => @field).to_s
    end
  end
end