module UI
  class DateTextBox
    Asset::register("javascripts/dateparse.js", UI::asset_path + "javascripts/dateparse.js")

    def self.build(date_options)
      if date_options && date_options.is_a?(Array) && !date_options[0].blank?
        ::Date.civil(*date_options.map { |component| component.to_i })
      else
        nil
      end
    end

    def initialize(context, object, name, field, options = {})
      @context = context
      @object = object
      @name = name
      @field = field
    end

    def to_s
      @context.render("ui/date_text_box.html.erb", { :object => @object, :name => @name, :field => @field }).to_s
    end
  end
end