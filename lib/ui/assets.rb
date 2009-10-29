# Register commonly used (generic) assets

module UI
  
  Asset::register("javascripts/admin.js", UI::asset_path + "javascripts/admin.js")
  Asset::register("javascripts/default.js", UI::asset_path + "javascripts/default.js")
  Asset::register("javascripts/date.js", UI::asset_path + "javascripts/date.js")
  Asset::register("javascripts/jquery.datePicker.js", UI::asset_path + "javascripts/jquery.datePicker.js")
  Asset::register("javascripts/DD_belatedPNG_0.0.8a-min.js", UI::asset_path + "javascripts/DD_belatedPNG_0.0.8a-min.js")
  Asset::register("javascripts/jquery.js", UI::asset_path + "javascripts/jquery-1.3.2.min.js")
  
  Asset::register("stylesheets/admin.css", UI::asset_path + "stylesheets/admin.css")
  Asset::register("stylesheets/date_picker.css", UI::asset_path + "stylesheets/date_picker.css")

  Asset::register("images/delete_big.png", UI::asset_path + "images/delete_big.png")
  Asset::register("images/calendar.gif", UI::asset_path + "images/calendar.gif")
  Asset::register("images/spinner.gif", UI::asset_path + "images/spinner.gif")
  Asset::register("images/x_grey.png", UI::asset_path + "images/x_grey.png")
  Asset::register("images/x_black.png", UI::asset_path + "images/x_black.png")
  
end
