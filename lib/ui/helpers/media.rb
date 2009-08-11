module UI
  module Helpers
    module Media
      def bytes_to_human_size(bytes)
        bytes = bytes.to_f
        bytes_in_kb = bytes / 1024
        bytes_in_mb = bytes_in_kb / 1024

        if bytes_in_mb >= 0.1
          "%2.1f MB" % bytes_in_mb
        else
          "%2.1f KB" % bytes_in_kb
        end
      end

      def normalize_file_extension(file_extension)
        return unless file_extension && file_extension != ""

        file_extension = file_extension.upcase

        if index = file_extension.index(".")
          file_extension[(index + 1)..-1]
        else
          file_extension
        end
      end
    end
  end
end

Harbor::ViewContext.send(:include, UI::Helpers::Media)