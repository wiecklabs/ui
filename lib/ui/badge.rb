require "fileutils"

module UI

  class Color
    WHITE = "#ffffff"
    BLACK = "#111111"
    BLUE  = "#2222cc"
    RED   = "#cc2222"
    GREEN = "#22cc22"
    GOLD  = "#ffcccc"
    ORANGE= "#ee3311"

    def self.brighten(color)
      "#" + self.adjust_channels(color, "11")
    end

    def self.darken(color)
      "#" + self.adjust_channels(color, "-11")
    end

    def self.adjust_channels(hex_value, adjustment)
      channels = hex_value[1..-1].scan(/\w{2}/)
      adjustment = adjustment.hex

      channels.map do |channel|
        channel = channel.hex + adjustment
        if channel <= 0 then "00"
        elsif channel > "ff".hex then "ff"
        else channel.to_s(16)
        end
      end.join

    end
  end

  class Badge

    def self.public_path=(path)
      @@public_path = path
    end

    def self.public_path
      Pathname(@@public_path).expand_path.to_s
    rescue NameError
      raise "UI::Badge::public_path not set."
    end

    attr_accessor :title, :subtitle, :background_color, :title_color, :subtitle_color

    def initialize(title, subtitle = nil, background_color = nil, title_color = Color::WHITE, subtitle_color = Color::GOLD)
      @title, @subtitle = title, subtitle
      @background_color, @title_color, @subtitle_color = background_color, title_color, subtitle_color
    end

    def to_s
      generate_badge unless File.exists?(filename)
      unrooted_path
    end

    private

    def generate_badge
      FileUtils.mkdir_p(File.dirname(self.class.public_path + unrooted_path))
      system(convert_command)
    end

    def path
      self.class.public_path + unrooted_path
    end

    def unrooted_path
      "/images/badges/#{filename}"
    end

    def filename
      filename  = title.downcase
      filename << ("_" + subtitle.gsub(/[^\w]/, "_")) if subtitle
      filename << "_#{background_color[1..-1].downcase}_#{title_color[1..-1].downcase}_#{subtitle_color[1..-1].downcase}"
      filename << ".gif"
    end

    def font_path
      Pathname(__FILE__).dirname.expand_path + "fonts"
    end

    def convert_command
      cmd  = "convert -size 42x20 xc:none "

      # Prepare canvas with rounded box
      cmd << "-fill '#{background_color}' -stroke '#{Color.darken(background_color)}' -draw 'roundRectangle 0, 0, 40, 18, 2, 2' "

      # Apply shine to box
      cmd << "-fill '#{Color.brighten(background_color)}' -stroke none -draw 'roundRectangle 1, 1, 39, 9, 1, 1' "

      # Now let's apply the basic font settings

      cmd << "-blur 0x.3 -gravity North "
      cmd << "-font #{font_path + "TahomaBold.ttf"} "
      cmd << "-pointsize 10 -fill '#{title_color}' "

      cmd << "-draw \"text -1, #{subtitle ? 2 : 4} '#{title}'\" "

      # If we have a subtitle, add that, too

      if subtitle
        cmd << "-gravity North "
        cmd << "-font #{font_path + "Silkscreen.ttf"} "
        cmd << "-pointsize 8 -fill '#{subtitle_color}' "
        cmd << "-draw \"text 0, 11 '#{subtitle}'\" "
      end

      # DONE!
      cmd << path
    end

  end
end

if __FILE__ == $0
  UI::Badge.public_path = "/tmp"
  puts UI::Badge.new("MOV", nil, UI::Color::BLUE)
  puts UI::Badge.new("MOV", "16:9", UI::Color::BLUE)
  puts UI::Badge.new("HIRES", "16:9", UI::Color::BLUE)
  puts UI::Badge.new("WMV", nil, UI::Color::GREEN)
  puts UI::Badge.new("FLV", "16:9", UI::Color::RED)
  puts UI::Badge.new("SRC", nil, UI::Color::ORANGE)
  `open /tmp/images/badges/*`
end