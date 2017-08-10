require 'html-proofer'
require 'date'

task default: %w[test]

task :watch do
  puts "=" * 80
  puts "Watching for changes"
  puts "=" * 80
  sh "bundle exec jekyll serve"
end

task :test do
  puts "=" * 80
  puts "Checking `./_site` for any dead links."
  puts "=" * 80
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory( "./_site", { :disable_external => true } ).run
end

task :create_post, [ :date, :title, :category ] do | b, args |
  d = args.date ? DateTime.parse( args.date ) : DateTime.now()
  unless args.title
    puts "A title is required to create a post"
    puts "e.g. rake #{ b }[,title-for-post]"
    exit 99
  end
  case args.category
  when "dress_code", "dress-code", "dc"
    c = { name: "dress-code", path: "dress-code/_posts" }
  when "works", "w"
    c = { name: "works", path: "works/_posts" }
  else
    c = { name: "writing", path: "_posts" }
  end
  headline "Creating a post with title #{ args.title } @ #{ d } categorized by #{ c[ :name ] }"
  filename = "#{ d.strftime "%F" }-#{ args.title.dasherize.downcase! }.markdown"
  filepath = "#{ c[ :path ] }/#{ filename }"
  unless File.exists?( filepath )
    post = File.new( filepath, "w+" )
    post.puts "-" * 3
    post.puts "layout: post"
    post.puts "title: #{ args.title.titleize }"
    post.puts "date: \"#{ d.strftime "%FT%T%:z" }\""
    post.puts "categories: [#{ c[ :name ] }]" if c[ :name ] == "works"
    post.puts "-" * 3
    post.close
    sh "cat #{ filepath }"
  else
    puts "Bailing on creating a post, looks like one already exists. lol."
    puts "#{ filepath }"
    exit 99
  end
end
