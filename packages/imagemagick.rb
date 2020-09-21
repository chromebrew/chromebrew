require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.11-29-7.0.10-29'
  compatibility 'all'

  is_fake

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "  Select the version to install:"
    puts "  6 = ImageMagick 6.9.11-29"
    puts "  7 = ImageMagick 7.0.10-29"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
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
        puts "  Please select from one of the options or enter 0 to cancel."
      end
    end
  end
end
