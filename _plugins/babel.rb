#
# BabelJS Jekyll Convertor
# Easily include ES2015 and ES2016 code into your Jekyll site without relying on
# anything but Ruby and the Babel Ruby Bridge.
#

require 'babel/transpiler'

module Jekyll

  class ESNext < Converter

    safe true
    priority :low

    def matches( ext )
      ext =~ /^\.js/i
    end

    def output_ext( ext )
      '.js'
    end

    def convert( content )
      begin
        transpile content
      rescue => e
        puts "Babel Exception: #{ e.message }"
      end
    end

    private

    #
    # Transpile any .js files found the _babel directory that are referenced by
    # the main.js file
    # @param {String} source The contents of the js/main.esnext
    # @returns {String} The code to put into the contents of main.js
    #
    def transpile( source )

      babel = @config[ 'babel' ]
      options = {
        'modules' => babel[ 'modules' ],
        'moduleIds' => true,
      }
      files = []

      Dir.glob( babel[ 'source' ] + '/**/*.js' ).sort.each do | js |

        if File.file? js

          options[ 'filename' ] = js.gsub( /^_.*\/|\.js/, '' )

          js = Babel::Transpiler.transform( File.read( js ), options )

          files.push js[ 'code' ]

        end

      end


      options[ 'filename' ] = nil
      options[ 'modules' ] = 'ignore'
      options[ 'moduleIds' ] = false;
      main_code = Babel::Transpiler.transform( source, options )
      files.push main_code[ 'code' ]

      files.join "\n"

    end

  end

end
