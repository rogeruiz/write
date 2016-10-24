source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse( open( 'https://pages.github.com/versions.json' ).read )

gem 'jekyll', '~> 3.x.x'
gem 'html-proofer'
gem 'bundler', '>= 1.8.4'
gem 'github-pages', versions[ 'github-pages' ]
gem 'rake'
