require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-34-7.0.7-22'

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "Enter the ImageMagick version to install:"
    puts "6 = ImageMagick 6.9.9-34"
    puts "7 = ImageMagick 7.0.7-22"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-34.tar.xz'
        source_sha256 'b37d8ea71a367f0d2267e8441b470cc6f2eaac0ce94837dcc87b011c55bf212c'
        binary_url ({
        })
        binary_sha256 ({
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-22.tar.xz'
        source_sha256 '49de9e08ea255a1f939158d85d50dfa29285bccbdcb7fee0fe4309061d438489'
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
  depends_on 'libwebp'
  depends_on 'freetype'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python27'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--with-python',
           '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
