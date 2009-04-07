require "fileutils"
require "pathname"

module UI

  class Color
    WHITE = "#ffffff"
    BLACK = "#111111"
    BLUE  = "#2222cc"
    RED   = "#cc2222"
    GREEN = "#22cc22"
    GOLD  = "#ffffaa"
    ORANGE= "#ee3311"

    def self.brighten(color, amount = "11")
      "#" + self.adjust_channels(color, amount)
    end

    # def self.lighten(color, amount = "33")
    #   channels = color[1..-1].scan(/\w{2}/).map { |c| c.hex }.sort
    #   if channels[0] == channels[1] == channels[2]
    #     channels.map { |c| (c.hex + amount.hex).to_s(16) }.join
    #   end
    # end

    def self.darken(color, amount = "-11")
      "#" + self.adjust_channels(color, amount)
    end

    def self.adjust_channels(hex_value, adjustment)
      channels = hex_value[1..-1].scan(/\w{2}/)
      adjustment = adjustment.hex

      channels.map do |channel|
        channel = channel.hex + adjustment
        if channel <= 0 then "00"
        elsif channel > "ff".hex then "ff"
        else
          channel.to_s(16).rjust(2, "0")
        end
      end.join

    end
  end

  class Badge

    attr_accessor :title, :subtitle, :background_color, :title_color, :subtitle_color

    def initialize(title, subtitle = nil, background_color = Color::BLUE, title_color = Color::WHITE, subtitle_color = Color::GOLD)
      @title = title
      @background_color, @title_color, @subtitle_color = background_color, title_color, subtitle_color

      @subtitle = subtitle.to_s.size == 0 ? nil : subtitle
    end

    def to_s
      generate_badge unless File.exists?(path)
      unrooted_path
    end

    private

    def generate_badge
      FileUtils.mkdir_p(File.dirname(path))
      system(convert_command)
    end

    def path
      UI.public_path + unrooted_path
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
      cmd << "-fill '#ffffff40' -stroke none -draw 'roundRectangle 1, 1, 39, 9, 1, 1' "

      # Now let's apply the basic font settings

      cmd << "-gravity North "
      cmd << "-font #{font_path + "TahomaBold.ttf"} "
      cmd << "-pointsize 10.5 -fill '#{title_color}' "

      # Draw the text a few times using a darker color
      cmd << "-fill '#{Color.darken(background_color, "-33")}' "

      offset = subtitle ? 0 : 3

      cmd << "-draw \"text -2, #{offset - 1} '#{title}'\" "
      cmd << "-draw \"text 0, #{offset - 1} '#{title}'\" "
      cmd << "-draw \"text -2, #{offset + 1} '#{title}'\" "
      cmd << "-draw \"text 0, #{offset + 1} '#{title}'\" "

      # Overlay white on top of the dark text for a nice effect
      cmd << "-fill '#{title_color}' "
      cmd << "-draw \"text -1, #{offset} '#{title}'\" "

      # If we have a subtitle, add that, too

      if subtitle
        cmd << "-gravity North "
        cmd << "-font #{font_path + "Silkscreen.ttf"} "
        cmd << "-pointsize 8 -fill '#{subtitle_color}' "
        cmd << "-draw \"text 0, 10 '#{subtitle}'\" "
      end

      # DONE!
      cmd << path
    end

  end
end

if __FILE__ == $0
  `rm -r /tmp/images`
  UI.public_path = "/tmp"
  path = UI::Badge.new("MP3", nil, "#a10007").to_s
  `open /tmp#{path}`
  # UI::Badge.new("FLV", nil, "#cc1122").to_s
  # UI::Badge.new("WMV", nil, "#88dd00").to_s
  # UI::Badge.new("MOV", nil, "#1188cc").to_s
  # UI::Badge.new("MOV", "HI-RES", "#000000").to_s
  # 
  # `open /tmp/images/badges/*`

  # puts UI::Badge.new("MOV", "16:9", UI::Color::BLUE)
  # puts UI::Badge.new("HIRES", "16:9", UI::Color::BLUE)
  # puts UI::Badge.new("WMV", nil, UI::Color::GREEN)
  # puts UI::Badge.new("FLV", "16:9", UI::Color::RED)
  # puts UI::Badge.new("SRC", nil, UI::Color::ORANGE)
  # puts UI::Badge.new("SAMP", "MeCrazy", UI::Color::ORANGE)
  # puts UI::Badge.new("TST", '', UI::Color::ORANGE)
  # `open /tmp/images/badges/*`
  # cc1122 -> dd5566
  # 0600ff -> 5555ff
  # 88dd00 -> aaee33
  # 1188cc -> 55aadd
  # 000000 -> 444444
end