module UI
  module Javascripts
    class DefaultInputs
      Asset::register("javascripts/default_inputs.js", UI::asset_path + "javascripts/default_inputs.js")

      def to_s
        Harbor::View.new("ui/javascripts/default_inputs").to_s
      end
    end
  end
end