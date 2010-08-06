module UI
  
  class SocialMedia
    
    # The list of all of the available social media bookmarklets
    @@sites = {
      'reddit' => 'http://reddit.com/submit?url=URL&title=TITLE',
      'digg' => 'http://digg.com/submit?url=URL&title=TITLE&media=news',
      'facebook' => 'http://www.facebook.com/sharer.php?u=URL&t=TITLE',
      'stumbleupon' => 'http://www.stumbleupon.com/submit?url=URL&title=TITLE',
      'delicious' => 'http://del.icio.us/post?url=URL&title=TITLE',
      'twitter' => 'http://twitter.com/home?status=TITLE%20URL',
      'google' => 'http://www.google.com/bookmarks/mark?op=edit&bkmk=URL&title=TITLE',
      'yahoo' => 'http://myweb2.search.yahoo.com/myresults/bookmarklet?u=URL&t=TITLE',
      'newsvine' => 'http://www.newsvine.com/_wine/save?u=URL&h=TITLE',
      'technorati' => 'http://technorati.com/faves/?add=URL'
    }
    # more here: http://kevin.vanzonneveld.net/techblog/article/list_of_social_bookmarking_sites

    def self.configure(&block)
      yield(@@sites)
    end
    
    def self.sites
      @@sites
    end
    
    attr_accessor :sites
    
    # Takes a title and a url, which are passed to the bookmarklets. The sites arguement
    # can be used to specify which bookmarklets to use, or can override elements in the 
    # existing list. By default, no bookmarklets are shown.
    def initialize(context, title, url, sites=nil)
      @context = context
      @url = url
      @title = title #.sub(/ /,"%20")
      
      if sites.is_a?(Hash)
        # use the provided hash instead of the built in one
        names = sites.keys
      elsif sites.is_a?(Array)
        # use only the sites provided in the array
        names = @@sites.keys.select {|k| sites.include?(k) }
      elsif sites == :all
        names = @@sites.keys
      else
        # use none of the available bookmarklets
        names = []
      end 

      # check for and register icons
      names.each do |name|
        if UI::Asset.entries["images/social_media/#{name}.gif"]
          next # already registered, should NOT be overridden
        elsif ::File.exists?(UI::asset_path + "images/social_media/#{name}.gif")
          Asset::register("images/social_media/#{name}.gif", UI::asset_path + "images/social_media/#{name}.gif")
        else
          Asset::register("images/social_media/#{name}.gif", UI::asset_path + "images/locales/unknown.gif")
        end
      end
      
      # if Cleat is available, shorten the URL
      if defined? @context.cleat
        @short_url = @context.q( @context.cleat(@url) )
        @short_title = @title[0..139-@short_url.size]
        
        # if we had to truncate the title, add an ellipsis
        @short_title += "…" if @short_title != @title
      end
      
      urls = names.map {|name| url(name) }
      @sites = names.zip(urls)
    end
    
    # Returns the bookmarklet URL for the page.
    def url(site)
      @@sites[site.downcase].sub(/URL/, @context.q(@short_url || @url)).sub(/TITLE/, @context.q(@short_title || @title))
    end
    
    def to_s
      @to_s ||= @context.render "ui/social_media", :sites => sites
    end
    
  end
  
end