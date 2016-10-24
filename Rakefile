require 'html-proofer'

task default: %w[test]

task :test do
  puts "=" * 80
  puts "Checking `./_site` for any dead links."
  puts "=" * 80
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory( "./_site", { :disable_external => true } ).run
end
