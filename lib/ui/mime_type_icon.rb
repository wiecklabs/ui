module UI
  class MimeTypeIcon

    def self.register(mime_type, icon)
      (@icons ||= {})[mime_type] = icon
    end

    def self.default
      @default || "images/icon_generic.gif"
    end

    def self.default=(value)
      @default = value
    end

    def self.[](content_type)
      UI::Asset.new(@icons[content_type] || default)
    end

    register "text/plain", "images/icon_txt.gif"
    register "application/msword", "images/icon_doc.gif"
    register "application/pdf", "images/icon_pdf.gif"
    register "application/xls", "images/icon_xls.gif"
    register "audio/x-wav", "images/icon_audio.gif"
    register "audio/mpeg", "images/icon_audio.gif"

  end

  Asset::register("images/icon_audio.gif", asset_path + "images/icon_audio.gif")
  Asset::register("images/icon_generic.gif", asset_path + "images/icon_generic.gif")
  Asset::register("images/icon_doc.gif", asset_path + "images/icon_doc.gif")
  Asset::register("images/icon_pdf.gif", asset_path + "images/icon_pdf.gif")
  Asset::register("images/icon_xls.gif", asset_path + "images/icon_xls.gif")
  Asset::register("images/icon_txt.gif", asset_path + "images/icon_txt.gif")
end
