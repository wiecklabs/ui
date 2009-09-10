require 'fileutils'

module UI
  class Asset

    def self.register(unrooted_path, source_path)
      (@@assets ||= {})[unrooted_path] = source_path
    end

    def self.copy_assets!
      @@assets.each do |unrooted_path, source_path|
        public_path = Pathname(UI::public_path) + unrooted_path
        begin
          FileUtils.cp_r(source_path, public_path)
        rescue
          puts "Failed to copy asset (#{source_path}, #{public_path})"
        end
      end
      true
    end

    def initialize(unrooted_path)
      @unrooted_path = unrooted_path

      unless @source_path = @@assets.fetch(@unrooted_path, nil)
        raise ArgumentError.new("#{unrooted_path} is not a registered asset. Use UI::Asset#register(unrooted_path, full_path).")
      end

      create unless exists?
    end

    def public_path
      @public_path ||= Pathname(UI::public_path) + @unrooted_path
    end

    def to_s
      '/' + @unrooted_path
    end

    def exists?
      File.exists?(public_path)
    end

    private

    def create
      FileUtils.mkdir_p(public_path.parent)
      FileUtils.cp_r(@source_path, public_path)
    end
  end
end
