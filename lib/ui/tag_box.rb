module UI
  class TagBox < Struct.new(:context, :tags, :name)

    def to_s
      context.render("ui/tag_box", :tags => tags, :name => name)
    end
  end

  Asset.register("javascripts/jquery.tagbox.js", asset_path + "javascripts/jquery.tagbox.js")
  Asset.register("stylesheets/jquery.tagbox.css", asset_path + "stylesheets/jquery.tagbox.css")
end