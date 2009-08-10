# Register commonly used (generic) assets

module UI
  
  Asset::register("javascripts/date.js", UI::asset_path + "javascripts/date.js")
  
  Asset::register("stylesheets/date_picker.css", UI::asset_path + "stylesheets/date_picker.css")
  
  Asset::register("images/calendar.gif", UI::asset_path + "images/calendar.gif")
  Asset::register("images/spinner.gif", UI::asset_path + "images/spinner.gif")
  
end