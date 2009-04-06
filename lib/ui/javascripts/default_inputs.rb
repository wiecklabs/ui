module UI
  module Javascripts
    class DefaultInputs
      def to_s
        Wheels::View.new("ui/javascripts/default_inputs").to_s
      end
    end
  end
end