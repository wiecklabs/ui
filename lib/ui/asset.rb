require 'fileutils'

module UI
  class Asset

    def self.register(unrooted_path, source_path)
      (@@assets ||= {})[unrooted_path] = Source.new(source_path)
    end

    def self.copy_assets!
      @@assets.each do |unrooted_path, source|
        public_path = Pathname(UI::public_path) + unrooted_path
        begin
          FileUtils.mkdir_p(Pathname(public_path).dirname)
          FileUtils.cp_r(source.path, public_path)
        rescue => ex
          puts "Failed to copy asset (#{source.path}, #{public_path}): #{ex.inspect}"
        end
      end
      true
    end

    def initialize(unrooted_path)
      @unrooted_path = "assets/#{unrooted_path}"

      unless @source = @@assets.fetch(unrooted_path, nil)
        raise ArgumentError.new("#{unrooted_path} is not a registered asset. Use UI::Asset#register(unrooted_path, full_path).")
      end
    end

    def public_path
      @public_path ||= Pathname(UI::public_path) + @unrooted_path
    end

    def to_s
      create if !exists? || @source.modified > modified
      '/' + @unrooted_path
    end

    def modified
      File.mtime(public_path)
    end

    def exists?
      File.exists?(public_path)
    end

    private

    def create
      FileUtils.mkdir_p(public_path.parent)
      FileUtils.cp_r(@source.path, public_path)
    end

    class Source

      attr_accessor :path

      def initialize(path)
        @path = path
      end

      def modified
        File.mtime(@path)
      end
    end
  end
end
