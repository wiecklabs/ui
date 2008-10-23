require "enumerator"
require "date"

module UI
  class Calendar

    attr_accessor :events

    def initialize(events)
      @events = events.sort
    end

    def start_date
      @start_date ||= @events.first.timestamp
    end

    def end_date
      @end_date ||= @events.last.timestamp
    end

    def months
      Month.new(start_date.year, start_date.month)..Month.new(end_date.year, end_date.month)
    end

    def to_s(options = {})
      if options[:size] == :small
        Wheels::View.new("ui/calendar/small", :calendar => self).to_s
      else
        Wheels::View.new("ui/calendar/calendar", :calendar => self).to_s
      end
    end

    class Event

      attr_accessor :timestamp, :title, :options

      def initialize(timestamp, title, options = {})
        @timestamp = timestamp
        @title = title
        @options = options
      end

      def <=>(other)
        timestamp <=> other.timestamp
      end

      def on?(date)
        self.date == date
      end

      def date
        Date.new(timestamp.year, timestamp.month, timestamp.day)
      end

      def type
        @options[:type]
      end

    end

    class Month
      include Comparable

      attr_accessor :date

      def initialize(year, month)
        @date = Date.new(year, month)
      end

      def succ
        date = Date.new(@date.year, @date.month, -1) + 1
        self.class.new(date.year, date.month)
      end

      def <=>(other)
        self.date <=> other.date
      end

      def to_s
        @date.strftime("%B %Y")
      end

      def to_a
        month = []
        days = [].fill(nil, 0, date.wday)
        days += (date..Date.new(date.year, date.month, -1)).to_a
        days << nil until days.size % 7 == 0
        days.each_slice(7) { |week| month << week }
        month
      end

    end
  end
end