require 'fileutils'

module UI
  class Asset

    def self.register(unrooted_path, source_path)
      (@@assets ||= {})[unrooted_path] = source_path
    end

    def self.copy_assets!
      @@assets.each do |unrooted_path, source_path|
        public_path = Pathname(UI::public_path) + unrooted_path
        FileUtils.cp(source_path, public_path)
      end
    end

    def initialize(unrooted_path)
      @unrooted_path = unrooted_path

      unless source_path = @@assets.fetch(@unrooted_path, nil)
        raise ArgumentError.new("#{unrooted_path} is not a registered asset. Use UI::Asset#register(unrooted_path, full_path).")
      end

      public_path = Pathname(UI::public_path) + @unrooted_path
      FileUtils.cp(source_path, public_path) unless File.file?(public_path)
    end

    def to_s
      '/' + @unrooted_path
    end
  end
end