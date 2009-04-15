module UI
  class Color
    WHITE = "#ffffff"
    BLACK = "#111111"
    BLUE  = "#2222cc"
    RED   = "#cc2222"
    GREEN = "#22cc22"
    GOLD  = "#ffffaa"
    ORANGE= "#ee3311"

    def self.colors
      colors = constants.select do |name|
        next unless name =~ /[A-Z]+/
        value = const_get(name)
        value.is_a?(String) && value =~ /\#[0-9a-f]{6}/
      end

      if block_given?
        colors.each do |name|
          yield name, const_get(name)
        end
      end

      colors
    end

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
end