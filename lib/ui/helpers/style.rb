module UI
  module Helpers
    module Style

      # Alternates between first and second values using the caller's context
      # for tracking.
      # 
      # Usage:
      #   <% @users.each do |user| %>
      #   <tr class="<%= stripe("highlight", nil) %>"> ... </tr>
      #   <% end %>
      # 
      def stripe(first, second)
        context = caller[0].hash

        (@__stripes ||= {})[context] = !@__stripes[context]
        @__stripes[context] ? first : second
      end

    end
  end
end

Harbor::ViewContext.send(:include, UI::Helpers::Style)