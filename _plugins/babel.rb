##
#
# BabelJS Jekyll convertor
# Easily include ES2015 and ES2016 code into your Jekyll site without relying on
# anything but Ruby.
#
##

module Jekyll

  class ESNext < Converter

    safe true
    priority :low

    def setup
      return if @has_run

      require 'babel/transpiler'

      dir = @config[ 'babel' ][ 'source' ]
      @files = Dir.foreach( dir ).select { |f| File.file? "#{ dir }/#{ f }" }

      @options = {}
      @options[ 'filename' ] = 'main'
      @options[ 'modules' ] = 'amd'
      @options[ 'moduleIds' ] = true

      @has_run = true

    rescue LoadError

      STDERR.puts 'Babel not installed'
      raise FatalExecption.new( 'Missing gem: Babel' )

    end

    def matches( ext )
      ext =~ /^\.esnext/i
    end

    def output_ext( ext )
      '.js'
    end

    def convert( content )
      begin
        setup
        transpile content, @options
      rescue => e
        puts "Babel Exception: #{ e.message }"
      end
    end

    private

    #
    # Transpile any .esnext files found the _babel directory
    #
    def transpile( source, options )
      code = []
      dir = @config[ 'babel' ][ 'source' ]
      @files.each do |x|
        code.push( Babel::Transpiler.transform( "#{ dir }/#{ x }", options ) )
      end
      code.push( Babel::Transpiler.transform( source, options ) )
      puts code
    end

  end

end
