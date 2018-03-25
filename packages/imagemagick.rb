require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-39-7.0.7-27'

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "Enter the ImageMagick version to install:"
    puts "6 = ImageMagick 6.9.9-39"
    puts "7 = ImageMagick 7.0.7-27"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        source_url 'https://www.imagemagick.org/download/ImageMagick-6.9.9-39.tar.gz'
        source_sha256 '78380b6f9b0ebfbf7f1630769ffd626dc9106807d0acd62ebc556a3b80830cb8'
        binary_url ({
        })
        binary_sha256 ({
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/ImageMagick-7.0.7-27.tar.gz'
        source_sha256 'eb73af01344eba5bfa1be4360a67c4b278cfb752da5b14055290d08bf22b88ce'
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

  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'lcms'
  depends_on 'lzma'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'msttcorefonts'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'perl'
  depends_on 'python27'
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
