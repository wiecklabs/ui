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
        raise StandardError.new("Failed to find a matching locale flag image for #{locale}")
      end
      Asset::register("images/locales/#{@culture_code}.gif", UI::asset_path + "images/locales/#{@culture_code}.gif")
    end
    
    def to_s
      @to_s ||= UI::Asset.new("images/locales/#{@culture_code}.gif").to_s
    end
    
  end
  
end