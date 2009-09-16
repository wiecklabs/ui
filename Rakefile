require "rubygems"
require "pathname"
require "rake"
require "rake/gempackagetask"
require "rake/testtask"

NAME = "ui"
SUMMARY = "Harbor UI Components"

GEM_VERSION = "0.6.7"

task :default => :test

spec = Gem::Specification.new do |s|
  s.name = NAME
  s.summary = s.description = SUMMARY
  s.author = "Wieck Media"
  s.email = "dev@wieck.com"
  s.homepage = "http://www.wieck.com"
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.files = %w(Rakefile) + Dir.glob("lib/**/*")

  s.add_dependency "harbor"

end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install UI as a gem"
task :install => [:repackage] do
  sh %{gem install pkg/#{NAME}-#{GEM_VERSION}}
end

desc "Run tests"
task :test do
  Rake::TestTask.new('test') do |t|
    t.pattern = "test/**/*_test.rb"
    #t.warning = true
  end
end
