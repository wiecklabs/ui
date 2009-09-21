module UI

  class ErrorMessages
    def initialize(context, title, errors)
      @context = context
      @title = title
      @errors = errors
    end

    def to_s
      if @errors.any?
        Harbor::View.new("ui/error_messages", :errors => @errors, :title => @title).to_s
      else
        ''
      end
    end
    
    class FormFieldError

      attr_reader :object_field, :form_field_id, :message

      def initialize(object_field, form_field_id, message)
        @object_field, @form_field_id, @message = object_field, form_field_id, message
      end
      
      def to_s
        message
      end

    end

    ## 
    # DataMapperErrors provides a facility to allow UI::ErrorMessages to intelligently render
    # error messages from DataMapper instance validation errors
    ## 
    class DataMapperErrors < Harbor::Errors
      
      ##
      # The form_field_prefix will default to an underscored version of the class name if not
      # supplied.
      ##
      def initialize(instance, form_field_prefix = nil)
        @instance = instance
        @form_field_prefix = (form_field_prefix || instance.class.to_s.gsub(/(.)([A-Z])/, "\\1_\\2").downcase) + "_"
      end
      
      protected
      
      ##
      # This method taps into unsuported, private dm-validations code to gain access to the actual errors hash.
      # Perhaps we can use @instance.class.fields?
      ##
      def errors
        return [] unless @instance

        @errors ||= @instance.errors.send(:errors).map do |field, errors|
          errors.map do |message|
            FormFieldError.new(field.to_s, "#{@form_field_prefix}#{field.to_s}", message)
          end
        end.flatten
      end

    end

  end
  
end