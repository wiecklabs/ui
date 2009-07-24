require "harbor/locale"

# UI::LocaleFlag
#
# Registers flag images associated with locales.
# 
# Usage:
#
#   UI::LocaleFlag(locale)
#   or
#   UI::LocaleFlag("en-US")

module UI
  
  class LocaleFlag
    
    def initialize(locale)
      if locale.is_a?(String) and ::File.exists?(UI::asset_path + "images/locales/#{locale}.gif")
        @culture_code = locale
      elsif locale.respond_to?("culture_code") and ::File.exists?(UI::asset_path + "images/locales/#{locale.culture_code}.gif")
        @culture_code = locale.culture_code
      else
<<<<<<< HEAD:lib/ui/locale_flag.rb
        raise StandardError.new("Failed to find a matching locale flag image for #{locale}")
=======
        @culture_code = "unknown" # This allows us to fall back to "unknown.gif" so apps display a black flag rather than crashing
>>>>>>> 1d4351f2522b5cdfca458fa22638fb38607cfd6a:lib/ui/locale_flag.rb
      end
      Asset::register("images/locales/#{@culture_code}.gif", UI::asset_path + "images/locales/#{@culture_code}.gif")
    end
    
    def to_s
      @to_s ||= UI::Asset.new("images/locales/#{@culture_code}.gif").to_s
    end
    
  end
  
end