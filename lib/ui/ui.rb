require 'fileutils'

module UI
  
  @@public_path = nil
  def self.public_path=(value)
    @@public_path = value
  end

  def self.public_path
    return @@public_path if @@public_path
    Harbor::FileStore['public'] ? Harbor::FileStore['public'].root.to_s : @@public_path
  end

  def self.asset_path
    Pathname(__FILE__).dirname.parent.parent + "assets"
  end
end