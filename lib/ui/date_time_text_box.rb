module UI
  class DateTimeTextBox
    Asset::register("javascripts/dateparse.js", UI::asset_path + "javascripts/dateparse.js")
    Asset::register("javascripts/timeparse.js", UI::asset_path + "javascripts/timeparse.js")

    def self.default_offset=(offset)
      @default_offset = offset
    end

    def self.default_offset
      @default_offset || (Time.now.gmt_offset / 60 / 60)
    end
    
    def self.build(date_options)
      if date_options && date_options.is_a?(Array) && !date_options[0].blank?
        ::DateTime.civil(*date_options.map { |component| component.to_i })
      else
        nil
      end
    end

    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
      @offset = options.fetch(:offset, self.class.default_offset)
      @shortcuts = options.fetch(:shortcuts, {})
      @format_guide = options.fetch(:format_guide, nil)
      @disabled = options.fetch(:disabled, false)
    end

    def to_s
      @context.render("ui/date_time_text_box.html.erb", { :object => @object, :name => @name, :field => @field, :offset => @offset, :shortcuts => @shortcuts, :format_guide => @format_guide, :disabled => @disabled }).to_s
    end
  end
end