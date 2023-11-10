require 'package'
require_relative 'imagemagick6'
require_relative 'imagemagick7'

class Imagemagick < Package
  description Imagemagick7.description
  homepage Imagemagick7.homepage
  version "#{Imagemagick6.version}-#{Imagemagick7.version}"
  license Imagemagick7.license
  compatibility Imagemagick7.compatibility

  is_fake

  def self.preflight
    if ARGV.include?('install')
      imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
      abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
      puts "\n  Select the version to install:"
      puts "  6 = ImageMagick #{Imagemagick6.version}"
      puts "  7 = ImageMagick #{Imagemagick7.version}"
      puts '  0 = Cancel'

      while version = $stdin.gets.chomp.downcase
        case version
        when '6'
          depends_on 'imagemagick6'
          break
        when '7'
          depends_on 'imagemagick7'
          break
        when '0'
          abort
          break
        else
          puts '  Please select from one of the options or enter 0 to cancel.'
        end
      end
    end
  end
end
