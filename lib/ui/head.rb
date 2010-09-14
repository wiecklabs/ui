module UI

  class Head

    attr_accessor :title_format, :appended_values, :named_values

    def initialize
      @apply_title_format = true
      @title_format = nil
      @description = ''
      @keywords = []
      @appended_values = []
      @named_values = {}
    end

    # Append a section. (Used for anonymous captures from UI::Helpers::Head)
    def append(value)
      @appended_values << value
    end

    def description(value)
      @description = value.to_s
    end
    
    # Add a single keyword
    def keyword(value)
      @keywords << value
    end

    # Add a variable number of keywords
    def keywords(*values)
      values.any? ? @keywords.concat(values.flatten) : @keywords
    end

    # Set a named section. (Used for named captures from UI::Helpers::Head)
    def set(name, value)
      @named_values[name] = value
    end

    # Gets/sets the title
    def title(value = nil)
      value ? @title = value : @title
    end

    # Sets the title and turns off the application of the title format
    def title!(value)
      @apply_title_format = false
      title(value)
    end
    
    def separator(value)
      @separator = value
    end

    # Gets/sets the title_format
    # The value should expect to be a sprintf format string expecting a single argument that is the view's title.
    def title_format(value)
      value ? @title_format = value : @title_format
    end

    # Turn all this stuff in to html...
    def to_html
      html = ""

      formatted_title = format_title.to_s.strip
      html << "<title>#{formatted_title}</title>\n" if formatted_title.size > 0

      html << "<meta name=\"description\" content=\"#{@description}\" />\n" if @description.size > 0

      combined_keywords = @keywords.uniq.join(",")
      html << "<meta name=\"keywords\" content=\"#{combined_keywords}\" />\n" if combined_keywords.size > 0

      html << (@appended_values + @named_values.values).join("\n")
      html
    end

    private

    def format_title
      formatted_title = if @apply_title_format && @title_format && @title_format.size > 0
        @title_format % @title
      else
        @title
      end
      formatted_title.sub!(/(#{@separator}\s*)$/,'') if @separator
      
      formatted_title
    end

  end

end
