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
    # @param {String} source The contents of the js/main.esnext
    # @param {Object} options The options to pass into Babel
    # @returns {String} The code to put into the contents of main.js
    #
    def transpile( source, options )
      # Prepare a list for all the compiled code.
      codes = []
      dir = @config[ 'babel' ][ 'source' ]

      # Have Babel process all the code in the source directory and push it to
      # the `codes`.
      @files.each do |x|
        # Update the filename option for each file found
        sub_options = options.merge( { 'filename' => x.match( /^(\w+)\.esnext/i )[ 1 ] } )
        codes.push(
          Babel::Transpiler.transform(
            File.read( "#{ dir }/#{ x }" ),
            sub_options
          )
        )
      end

      # Process the source file last and push it into the `codes` array.
      codes.push( Babel::Transpiler.transform( source, options ) )
      codes.reduce( "\n" ) { |m, c| m + c[ 'code' ] + "\n\n" }
    end

  end

end
