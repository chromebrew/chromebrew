require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-33-7.0.7-21'

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "Enter the ImageMagick version to install:"
    puts "6 = ImageMagick 6.9.9-33"
    puts "7 = ImageMagick 7.0.7-21"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-33.tar.xz'
        source_sha256 '996adc81c91ebb589c0483b88ce4ddd76e91e0acee4858f71c9d024bda717869'
        binary_url ({
        })
        binary_sha256 ({
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-21.tar.xz'
        source_sha256 '3b2783a845279f76a4250f2c3caf04af22766e2d5f084bde589ebd73de6a0019'
        binary_url ({
        })
        binary_sha256 ({
        })
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end

  depends_on 'lcms'
  depends_on 'lzma'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'freetype'
  depends_on 'pango'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
