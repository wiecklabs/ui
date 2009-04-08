module UI
  class Button

    attr_accessor :text, :size, :text_color, :button_color, :background_color

    def initialize(text, size = 16, text_color = Color::BLACK, button_color = Color::WHITE, width = nil, height = nil)
      @text = text
      @size = size
      @text_color = text_color
      @button_color = button_color
      @width = width
      @height = height
    end

    def to_s
      generate_button unless File.exists?(path)
      unrooted_path
    end

    def width
      @width ||= ((text.size * size) * 0.55).to_i
    end

    def height
      @height ||= size + 10
    end

    def unrooted_path
      "/images/buttons/#{filename}"
    end

    def filename
      filename  = text.downcase.gsub(/[^\w]+/, "-")
      filename << "_#{text_color[1..-1].downcase}_#{button_color[1..-1].downcase}_#{width}_#{height}"
      filename << ".gif"
    end

    private

    def generate_button
      FileUtils.mkdir_p(File.dirname(path))
      system(convert_command)
    end

    def path
      UI.public_path + unrooted_path
    end

    def font_path
      Pathname(__FILE__).dirname.expand_path + "fonts"
    end

    def convert_command

      cmd = "convert -size #{width}x#{height} "

      # Draw button
      cmd << "xc:none -fill '#{button_color}' -stroke '#{Color.darken(button_color)}' "
      cmd << "-draw 'roundRectangle 0, 0, #{width - 4}, #{height - 4}, 4, 4' "

      # Add text
      cmd << "-stroke none -gravity Center -blur 0x.5 -font #{font_path + "MyriadPro-Semibold.otf"} "
      cmd << "-pointsize #{size} "

      cmd << "-fill '#{Color.darken(button_color)}' "
      cmd << "-draw \"text -1, -1 '#{text}'\" "
      cmd << "-draw \"text -1, 2 '#{text}'\" "
      cmd << "-draw \"text 1, -1 '#{text}'\" "
      cmd << "-draw \"text 1, 2 '#{text}'\" "

      cmd << "-fill '#{text_color}' "
      cmd << "-draw \"text 0, 0 '#{text}'\" "

      cmd << path
    end
  end
end

if __FILE__ == $0
  require "pathname"
  require Pathname(__FILE__).dirname + "badge"

  module UI
    def self.public_path
      '/tmp'
    end
  end

  puts UI::Button.new("Create Candidate", 16, "#559900")

  `open /tmp/images/buttons/*`
end