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
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-39.tar.xz'
        source_sha256 '56130c16790d8d38c3a1888cc07074d5b50ffb718243e0c56e4c88839edbf931'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-39-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-39-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-39-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-39-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '071bea4fdc809f539bf50cac533116d2e503930950cec5a38d5327bc0d079cfd',
           armv7l: '071bea4fdc809f539bf50cac533116d2e503930950cec5a38d5327bc0d079cfd',
             i686: 'ece2e339acfb29ae048e7042a68f673b442ef9f024490461906f2e205676ecdf',
           x86_64: '624ac10730c4b99c23a3049e0ec2a0a9ebdbd4662e7a3e2be8829636e3f187c4',
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-27.tar.xz'
        source_sha256 '543776f09d69e3ca29b1b83a9c0223185ba26bec673593840b4d7face6ea253b'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-27-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-27-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-27-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-27-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '2b60e59633eeb052949a7792bd8fde360db7a6c34e04c7ce6f7c1fadfe5411ea',
           armv7l: '2b60e59633eeb052949a7792bd8fde360db7a6c34e04c7ce6f7c1fadfe5411ea',
             i686: '8c549ac27f1d0a6248411662dc64d9cb96df5d00ef1808ec802f1dac875c0a2d',
           x86_64: 'd37404daaf575bf898be65c65aed1761d32031abaffd9eac2d2a6c29696febda',
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
