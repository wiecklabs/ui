namespace :ui do
  namespace :assets do
    desc "Copy registered assets into project."
    task :copy do
      UI::Asset.copy_assets!
    end
  end
end