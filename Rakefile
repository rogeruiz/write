require 'html-proofer'

task default: %w[test]

def headline( title )
  puts "=" * 80
  puts title
  puts "=" * 80
end

task :watch do
  headline "Watching for changes"
  sh "bundle exec jekyll serve"
end

task :test do
  headline "Checking `./_site` for any dead links."
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory( "./_site", { :disable_external => true } ).run
end
