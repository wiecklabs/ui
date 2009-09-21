require 'fileutils'

module UI
  def self.public_path=(path)
    @@public_path = path
  end

  def self.public_path
    Pathname(@@public_path).expand_path.to_s
  rescue NameError
    raise "UI::public_path not set."
  end

  def self.asset_path
    Pathname(__FILE__).dirname.parent.parent + "assets"
  end
end