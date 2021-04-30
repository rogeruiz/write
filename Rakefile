require 'html-proofer'
require 'date'

desc 'Runs test task by default.'
task default: %w[test]

def headline( title )
  puts "=" * 80
  puts title
  puts "=" * 80
end

desc 'Run the Jekyll server.'
task :watch do
  headline "Watching for changes"
  sh "bundle exec jekyll serve"
end

desc 'Run the built site through the test suite.'
task :test do
  headline "Checking `./_site` for any dead links."
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory( "./_site", { :disable_external => true } ).run
end

desc 'Create a post with date, title, and category (date defaults to now if left blank).'
task :create_post, [ :date, :title, :category ] do | b, args |
  d = args.date ? DateTime.parse( args.date ) : DateTime.now()
  layout_type = "post"
  unless args.title
    puts "A title is required to create a post"
    puts "e.g. rake #{ b }[,Title for Post]"
    exit 98
  end
  case args.category
  when "dress_code", "dress-code", "dc"
    c = { name: "dress-code", path: "dress-code/_posts" }
  when "works", "w"
    c = { name: "works", path: "works/_posts" }
    layout_type = "work"
  else
    c = { name: "writing", path: "_posts" }
  end
  headline "Creating a post with title #{ args.title } @ #{ d } categorized by #{ c[ :name ] }"
  filename = "#{ d.strftime "%F" }-#{ args.title.downcase.gsub(/\s/, '-') }.markdown"
  filepath = "#{ c[ :path ] }/#{ filename }"
  unless File.exists?( filepath )
    post = File.new( filepath, "w+" )
    post.puts "-" * 3
    post.puts "layout: #{ layout_type }"
    post.puts "title: #{ args.title }"
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
