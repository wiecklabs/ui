require "fileutils"
require "pathname"

require Pathname(__FILE__).dirname + "color"

module UI

  class Badge

    attr_accessor :title, :subtitle, :background_color, :title_color, :subtitle_color

    ##
    # Path to font to be used for badge titles. Tahoma Bold works well.
    ##
    def self.title_font=(font)
      @@title_font = font
    end

    def self.title_font
      @@title_font rescue nil
    end

    ##
    # Path to font to be used for badge subtitles. Best as a small, pixel font
    # such as Silkscreen.
    ##
    def self.subtitle_font=(font)
      @@subtitle_font = font
    end

    def self.subtitle_font
      @@subtitle_font rescue nil
    end

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

    def convert_command
      cmd  = "convert -size 42x20 xc:none "

      # Prepare canvas with rounded box
      cmd << "-fill '#{background_color}' -stroke '#{Color.darken(background_color)}' -draw 'roundRectangle 0, 0, 40, 18, 2, 2' "

      # Apply shine to box
      cmd << "-fill '#ffffff40' -stroke none -draw 'roundRectangle 1, 1, 39, 9, 1, 1' "

      # Now let's apply the basic font settings

      cmd << "-gravity North "
      cmd << "-font #{self.class.title_font} " if self.class.title_font
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
        cmd << "-font #{self.class.subtitle_font} " if self.class.subtitle_font
        cmd << "-pointsize 8 -fill '#{subtitle_color}' "
        cmd << "-draw \"text 0, 10 '#{subtitle}'\" "
      end

      # DONE!
      cmd << path
    end

  end
end


if __FILE__ == $0
  module UI
    def self.public_path
      '/tmp'
    end
  end

  `rm -r /tmp/images/badges` rescue nil

  puts path = UI::Badge.new("MP3", "++++", "#a10007").to_s

  `open /tmp/#{path}`
end