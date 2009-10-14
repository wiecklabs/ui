require "date"
require "time"

class UI::FormattedDate
	
	class UnknownDateFormatError < StandardError
		def initialize(format, locale)
		  registered_formats = UI::FormattedDate.formats.keys.map
			super("Could not find a match for Format Key='#{format}' and Locale='#{locale.inspect}' in the list of registered UI::FormattedDate formats")
		end
	end
	
	def self.register_format(format_key, format, locale = nil)
		@formats ||= Hash.new { |h, k| h[k] = {} }
		@formats[format_key][locale] = format
	end
	
	def self.get_format(format_key, locale)
	  @formats[format_key][locale] || @formats[format_key][nil]
  end
	
	def initialize(date, format_key, locale = nil)
		@format = self.class.get_format(format_key, locale)
		raise UnknownDateFormatError.new(format_key, locale) unless @format

		@date = date
	end
	
	def to_s
		return 'N/A' unless @date
		@date.strftime(@format)
	end
end
